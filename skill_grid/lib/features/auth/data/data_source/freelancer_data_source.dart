import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

abstract interface class IFreelancerDataSource {
  Future<void> registerFreelancer(FreelancerEntity freelancerEntity);
  Future<void> deleteFreelancer(String freelancerId);
  Future<FreelancerEntity> getFreelancerById(String freelancerId, String? token);
  Future<List<FreelancerEntity>> getAllFreelancers();
  Future<String> loginFreelancer(String email, String password);
  Future<void> updateFreelancer(FreelancerEntity freelancerEntity);
  Future<List<FreelancerEntity>> searchFreelancers(String searchQuery);
}