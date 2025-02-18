import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/education/data/data_source/education_data_source.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';

class EducationLocalDataSource implements IEducationDataSource {
  final HiveService _hiveService;
  EducationLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<List<EducationEntity>> getEducationByFreelancerId(
      String freelancerId, String? token) {
    try {
      return _hiveService
          .getEducationByFreelancerId(freelancerId)
          .then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception("Error retrieving education: $e");
    }
  }
}
