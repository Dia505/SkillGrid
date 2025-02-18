import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/employment/data/data_source/employment_data_source.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';

class EmploymentLocalDataSource implements IEmploymentDataSource {
  final HiveService _hiveService;
  EmploymentLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<List<EmploymentEntity>> getEmploymentByFreelancerId(String freelancerId, String? token) {
    try {
      return _hiveService
          .getEmploymentByFreelancerId(freelancerId)
          .then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception("Error retrieving employment: $e");
    }
  }
}