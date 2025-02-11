import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class GetFreelancerByIdParams {
  final String freelancerId;
  GetFreelancerByIdParams({required this.freelancerId});
}

class GetFreelancerByIdUseCase
    implements UsecaseWithParams<FreelancerEntity, GetFreelancerByIdParams> {
  final IFreelancerRepository freelancerRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  GetFreelancerByIdUseCase({
    required this.freelancerRepository,
    required this.tokenSharedPrefs
  });

  @override
  Future<Either<Failure, FreelancerEntity>> call(GetFreelancerByIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
       return Left(l);
    }, 
    (r) async {
      return freelancerRepository.getFreelancerById(params.freelancerId, r);
    });
  }
}
