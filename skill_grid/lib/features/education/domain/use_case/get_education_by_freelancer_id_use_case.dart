import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:skill_grid/features/education/domain/repository/education_repository.dart';

class GetEducationByFreelancerIdParams {
  final String freelancerId;
  GetEducationByFreelancerIdParams({required this.freelancerId});
}

class GetEducationByFreelancerIdUseCase
    implements
        UsecaseWithParams<List<EducationEntity>,
            GetEducationByFreelancerIdParams> {
  final IEducationRepository educationRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  GetEducationByFreelancerIdUseCase(
      {required this.educationRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, List<EducationEntity>>> call(
      GetEducationByFreelancerIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return educationRepository.getEducationByFreelancerId(
          params.freelancerId, r);
    });
  }
}
