import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/repository/review_repository.dart';

class GetReviewByFreelancerIdParams {
  final String freelancerId;
  GetReviewByFreelancerIdParams({required this.freelancerId});
}

class GetReviewByFreelancerIdUseCase implements UsecaseWithParams<List<ReviewEntity>, GetReviewByFreelancerIdParams> {
  final IReviewRepository reviewRepository;
  GetReviewByFreelancerIdUseCase({required this.reviewRepository});

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(GetReviewByFreelancerIdParams params) {
    return reviewRepository.getReviewByFreelancerId(params.freelancerId);
  }
}