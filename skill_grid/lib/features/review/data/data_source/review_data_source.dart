import 'package:skill_grid/features/review/domain/entity/review_entity.dart';

abstract interface class IReviewDataSource {
  Future<List<ReviewEntity>> getReviewByFreelancerId(String freelancerId);
  Future<List<ReviewEntity>> getReviewByRating(int rating);
  Future<void> saveReview(ReviewEntity reviewEntity, String? token);
  Future<ReviewEntity> getReviewByAppointmentId(String appointmentId, String? token);
}