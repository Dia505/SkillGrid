import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:skill_grid/features/employment/domain/repository/employment_repository.dart';

class GetEmploymentByFreelancerIdParams {
  final String freelancerId;
  GetEmploymentByFreelancerIdParams({required this.freelancerId});
}

class GetEmploymentByFreelancerIdUseCase
    implements
        UsecaseWithParams<List<EmploymentEntity>,
            GetEmploymentByFreelancerIdParams> {
  final IEmploymentRepository employmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetEmploymentByFreelancerIdUseCase(
      {required this.employmentRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, List<EmploymentEntity>>> call(
      GetEmploymentByFreelancerIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return employmentRepository.getEmploymentByFreelancerId(
          params.freelancerId, r);
    });
  }
}
