import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/data/data_source/remote_data_source/review_remote_data_source.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class ReviewRemoteRepository implements IReviewRepository {
  final ReviewRemoteDataSource _reviewRemoteDataSource;
  ReviewRemoteRepository(
      {required ReviewRemoteDataSource reviewRemoteDataSource})
      : _reviewRemoteDataSource = reviewRemoteDataSource;

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviewByFreelancerId(
      String freelancerId) async {
    try {
      final reviewList =
          await _reviewRemoteDataSource.getReviewByFreelancerId(freelancerId);
      print("review list: $reviewList");
      return Right(reviewList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviewByRating(
      int rating) async {
    try {
      final reviewList =
          await _reviewRemoteDataSource.getReviewByRating(rating);
      return Right(reviewList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
