import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class GetReviewByAppointmentIdParams {
  final String appointmentId;
  const GetReviewByAppointmentIdParams({required this.appointmentId});
}

class GetReviewByAppointmentIdUseCase
    implements UsecaseWithParams<ReviewEntity, GetReviewByAppointmentIdParams> {
  final IReviewRepository reviewRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetReviewByAppointmentIdUseCase(
      {required this.reviewRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, ReviewEntity>> call(
      GetReviewByAppointmentIdParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return reviewRepository.getReviewByAppointmentId(params.appointmentId, r);
    });
  }
}
