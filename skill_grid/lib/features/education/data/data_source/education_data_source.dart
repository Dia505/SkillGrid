import 'package:skill_grid/features/education/domain/entity/education_entity.dart';

abstract interface class IEducationDataSource {
  Future<List<EducationEntity>> getEducationByFreelancerId(String freelancerId, String? token);
}