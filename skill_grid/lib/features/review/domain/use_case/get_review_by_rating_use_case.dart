import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class GetReviewByRatingParams {
  final int rating;
  GetReviewByRatingParams({required this.rating});
}

class GetReviewByRatingUseCase implements UsecaseWithParams<List<ReviewEntity>, GetReviewByRatingParams> {
  final IReviewRepository reviewRepository;
  GetReviewByRatingUseCase({required this.reviewRepository});

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(GetReviewByRatingParams params) {
    return reviewRepository.getReviewByRating(params.rating);
  }
}