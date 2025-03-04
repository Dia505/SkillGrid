import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/notification/data/data_source/notification_data_source.dart';
import 'package:skill_grid/features/notification/data/model/notification_api_model.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';

class NotificationRemoteDataSource implements INotificationDataSource {
  final Dio _dio;
  NotificationRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<NotificationEntity>> getNotificationsByClientId(
      String clientId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getNotificationsByClientId}/$clientId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<NotificationApiModel> notificationApiModels =
            data.map((json) => NotificationApiModel.fromJson(json)).toList();

        return NotificationApiModel.toEntityList(notificationApiModels);
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
  Future<void> markNotificationAsRead(
      String notificationId, String? token) async {
    try {
      final dio = Dio();
      final String url =
          "${ApiEndpoints.markNotificationAsRead}/$notificationId/read";

      var response = await dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Notification marked as read successfully!");
      } else {
        throw Exception("Failed to mark notification as read");
      }
    } on DioException catch (e) {
      throw Exception("Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
