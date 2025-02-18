import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';

abstract interface class IEmploymentDataSource {
  Future<List<EmploymentEntity>> getEmploymentByFreelancerId(String freelancerId, String? token);
}