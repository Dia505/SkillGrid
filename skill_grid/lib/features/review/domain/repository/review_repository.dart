import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';

abstract interface class IReviewRepository {
  Future<Either<Failure, List<ReviewEntity>>> getReviewByFreelancerId(String freelancerId);
  Future<Either<Failure, List<ReviewEntity>>> getReviewByRating(int rating);
}