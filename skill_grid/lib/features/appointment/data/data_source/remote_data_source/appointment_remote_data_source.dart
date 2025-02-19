import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:skill_grid/features/appointment/data/dto/get_appointment_by_client_id_dto.dart';
import 'package:skill_grid/features/appointment/data/dto/get_appointment_by_id_dto.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';

class AppointmentRemoteDataSource implements IAppointmentDataSource {
  final Dio _dio;
  AppointmentRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> deleteAppointment(String appointmentId, String? token) async {
    try {
      final String url = "${ApiEndpoints.deleteAppointment}/$appointmentId";

      var response = await _dio.delete(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error occurred while deleting appointment: $e');
    }
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentByClientId(
      String clientId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getAppointmentByClientId}/$clientId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetAppointmentByClientIdDto> appointmentDto = data
            .map((json) => GetAppointmentByClientIdDto.fromJson(json))
            .toList();

        List<AppointmentApiModel> appointmentApiModels = appointmentDto
            .map((dto) =>
                AppointmentApiModel.fromGetAppointmentByClientIdDto(dto))
            .toList();

        return AppointmentApiModel.toEntityList(appointmentApiModels);
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
  Future<List<AppointmentEntity>> getAppointmentByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final String url =
          "${ApiEndpoints.getAppointmentByFreelancerId}/$freelancerId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("Parsed data: $data");

        List<AppointmentApiModel> appointmentApiModels =
            data.map((json) => AppointmentApiModel.fromJson(json)).toList();

        print("Appointment API Models: $appointmentApiModels");

        return AppointmentApiModel.toEntityList(appointmentApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<AppointmentEntity> getAppointmentById(
      String appointmentId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getAppointmentById}/$appointmentId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        GetAppointmentByIdDto appointmentDto =
            GetAppointmentByIdDto.fromJson(response.data);

        AppointmentEntity appointmentEntity =
            AppointmentApiModel.findAppointmentByIdDtoToEntity(appointmentDto);

        return appointmentEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error occurred while fetching appointment: $e');
    }
  }

  @override
  Future<void> saveAppointment(
      AppointmentEntity appointmentEntity, String? token) async {
    try {
      Response response = await _dio.post(ApiEndpoints.saveAppointment,
          data: {
            "appointment_purpose": appointmentEntity.appointmentPurpose,
            "appointment_date": appointmentEntity.appointmentDate,
            "project_duration": appointmentEntity.projectDuration,
            "appointment_time": appointmentEntity.appointmentTime,
            "project_end_date": appointmentEntity.projectEndDate,
            "status": appointmentEntity.status,
            "freelancer_service_id": appointmentEntity.freelancerService,
            "client_id": appointmentEntity.client
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateAppointment(String appointmentId,
      AppointmentEntity updatedAppointment, String? token) async {
    try {
      final String url = "${ApiEndpoints.updateAppointment}/$appointmentId";
      Map<String, dynamic> updateData = {};

      final currentAppointment =
          await _dio.get("${ApiEndpoints.getAppointmentById}/$appointmentId",
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ));

      final currentAppointmentData = currentAppointment.data;

      if (updatedAppointment.appointmentPurpose !=
          currentAppointmentData['appointment_purpose']) {
        updateData["appointment_purpose"] =
            updatedAppointment.appointmentPurpose;
      }

      // Proceed to update only changed fields
      if (updateData.isNotEmpty) {
        var response = await _dio.put(url,
            data: updateData,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ));

        if (response.statusCode == 200) {
        } else {
          throw Exception(response.statusMessage);
        }
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
