import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/review/data/data_source/review_data_source.dart';
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

        List<ReviewApiModel> reviewApiModels =
            data.map((json) => ReviewApiModel.fromJson(json)).toList();

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

  @override
  Future<void> saveReview(ReviewEntity reviewEntity, String? token) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.saveReview,
        data: {
          "review": reviewEntity.review,
          "rating": reviewEntity.rating,
          "review_date": reviewEntity.reviewDate,
          "client_id": reviewEntity.client.clientId,
          "freelancer_id": reviewEntity.freelancer.freelancerId,
          "appointment_id": reviewEntity.appointment.appointmentId 
        },
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          )
      );

      if(response.statusCode == 201) {
        return;
      }
      else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
