import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

abstract interface class IFreelancerDataSource {
  Future<void> registerFreelancer(FreelancerEntity freelancerEntity);
  Future<void> deleteFreelancer(String freelancerId);
  Future<FreelancerEntity> getFreelancerById(String freelancerId);
  Future<List<FreelancerEntity>> getAllFreelancers();
}