import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/review/data/data_source/review_data_source.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';

class ReviewLocalDataSource implements IReviewDataSource {
  final HiveService _hiveService;
  ReviewLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<List<ReviewEntity>> getReviewByFreelancerId(String freelancerId) async {
    try {
      return _hiveService.getReviewByFreelancerId(freelancerId).then((value) {
        return value.map((e) => e.toEntity()).toList();
    });
  }
  catch (e) {
      throw Exception("Error retrieving the freelancer's reviews: $e");
    }
  }

  @override
  Future<List<ReviewEntity>> getReviewByRating(int rating) async {
    try {
      return _hiveService.getReviewByRating(rating).then((value) {
        return value.map((e) => e.toEntity()).toList();
    });
  }
  catch (e) {
      throw Exception("Error retrieving reviews by rating: $e");
    }
  }
}