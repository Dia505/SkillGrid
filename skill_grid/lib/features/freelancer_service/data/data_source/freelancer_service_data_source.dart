import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

abstract interface class IFreelancerServiceDataSource {
  Future<List<FreelancerServiceEntity>> getFreelancerServiceByFreelancerId(String freelancerId);
}