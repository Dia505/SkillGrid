import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/review/data/data_source/review_data_source.dart';
import 'package:skill_grid/features/review/data/dto/get_review_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/review/data/dto/get_review_by_rating_dto.dart';
import 'package:skill_grid/features/review/data/model/review_api_model.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';

class ReviewRemoteDataSource implements IReviewDataSource {
  final Dio _dio;
  ReviewRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ReviewEntity>> getReviewByFreelancerId(
      String freelancerId) async {
    try {
      final String url =
          "${ApiEndpoints.getReviewByFreelancerId}/$freelancerId";
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetReviewByFreelancerIdDto> reviewDto = data
            .map((json) => GetReviewByFreelancerIdDto.fromJson(json))
            .toList();

        List<ReviewApiModel> reviewApiModels = reviewDto
            .map((dto) => ReviewApiModel.fromGetReviewByFreelancerIdD(dto))
            .toList();

        print("review api models: $reviewApiModels");

        return ReviewApiModel.toEntityList(reviewApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<List<ReviewEntity>> getReviewByRating(int rating) async {
    try {
      final String url = "${ApiEndpoints.getReviewByRating}/$rating";
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetReviewByRatingDto> reviewDto =
            data.map((json) => GetReviewByRatingDto.fromJson(json)).toList();

        List<ReviewApiModel> reviewApiModels = reviewDto
            .map((dto) => ReviewApiModel.fromGetReviewByRatingDto(dto))
            .toList();

        return ReviewApiModel.toEntityList(reviewApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
