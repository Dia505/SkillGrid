import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/data/data_source/local_data_source/review_local_data_source.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class ReviewLocalRepository implements IReviewRepository {
  final ReviewLocalDataSource _reviewLocalDataSource;
  ReviewLocalRepository({required ReviewLocalDataSource reviewLocalDataSource})
    : _reviewLocalDataSource = reviewLocalDataSource;

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviewByFreelancerId(String freelancerId) async {
    try {
      final reviewList = await _reviewLocalDataSource
          .getReviewByFreelancerId(freelancerId);
      return Right(reviewList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviewByRating(int rating) async {
    try {
      final reviewList = await _reviewLocalDataSource
          .getReviewByRating(rating);
      return Right(reviewList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> saveReview(ReviewEntity reviewEntity, String? token) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ReviewEntity>> getReviewByAppointmentId(String appointmentId, String? token) {
    throw UnimplementedError();
  }
}