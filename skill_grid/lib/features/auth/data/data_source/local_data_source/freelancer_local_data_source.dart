import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/auth/data/data_source/freelancer_data_source.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class FreelancerLocalDataSource implements IFreelancerDataSource {
  final HiveService _hiveService;
  FreelancerLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> registerFreelancer(FreelancerEntity freelancerEntity) async {
    try {
      final freelancerHiveModel =
          FreelancerHiveModel.fromEntity(freelancerEntity);
      await _hiveService.registerFreelancer(freelancerHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteFreelancer(String freelancerId) async {
    try {
      await _hiveService.deleteFreelancer(freelancerId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FreelancerEntity> getFreelancerById(
      String freelancerId, String? token) async {
    try {
      final freelancerHiveModel =
          await _hiveService.getFreelancerById(freelancerId);
      return freelancerHiveModel!.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<FreelancerEntity>> getAllFreelancers() {
    try {
      return _hiveService.getAllFreelancers().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> loginFreelancer(String email, String password) async {
    try {
      await _hiveService.loginFreelancer(email, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> updateFreelancer(FreelancerEntity freelancerEntity) async {
    try {
      final freelancerHiveModel =
          FreelancerHiveModel.fromEntity(freelancerEntity);
      await _hiveService.updateFreelancer(freelancerHiveModel);
    } catch (e) {
      throw Exception("Error updating freelancer: $e");
    }
  }

  @override
  Future<List<FreelancerEntity>> searchFreelancers(String searchQuery) async {
    try {
      return _hiveService.searchFreelancers(searchQuery).then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception('Error searching freelancers: $e');
    }
  }
}
