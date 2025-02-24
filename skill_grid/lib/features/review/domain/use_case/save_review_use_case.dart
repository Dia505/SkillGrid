import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class SaveReviewParams extends Equatable {
  final String review;
  final int rating;
  final DateTime reviewDate;
  final ClientEntity client;
  final FreelancerEntity freelancer;
  final AppointmentEntity appointment;

  const SaveReviewParams({
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  });

  const SaveReviewParams.initial({
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  });

  @override
  List<Object?> get props => [review, rating, reviewDate, client, freelancer, appointment];
}

class SaveReviewUseCase implements UsecaseWithParams<void, SaveReviewParams> {
  final IReviewRepository reviewRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  SaveReviewUseCase({
    required this.reviewRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, void>> call(SaveReviewParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if(role == "client") {
        final reviewEntity = ReviewEntity(
          review: params.review, 
          rating: params.rating, 
          reviewDate: params.reviewDate, 
          client: params.client, 
          freelancer: params.freelancer, 
          appointment: params.appointment
        );
        return reviewRepository.saveReview(reviewEntity, r);
      } else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}