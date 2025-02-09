import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/freelancer_service_data_source.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

class FreelancerServiceLocalDataSource implements IFreelancerServiceDataSource {
  final HiveService _hiveService;
  FreelancerServiceLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<List<FreelancerServiceEntity>> getFreelancerServiceByFreelancerId(String freelancerId) async {
    try {
      return _hiveService.getFreelancerServiceByFreelancerId(freelancerId).then((value) {
        return value.map((e) => e.toEntity()).toList();
    });
  }
  catch (e) {
      throw Exception("Error retrieving the freelancer's services: $e");
    }
}}