import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_hive_model.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';

class AppointmentLocalDataSource implements IAppointmentDataSource {
  final HiveService _hiveService;
  AppointmentLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> deleteAppointment(String appointmentId, String? token) async {
    try {
      await _hiveService.deleteAppointment(appointmentId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentByClientId(
      String clientId, String? token) {
    try {
      return _hiveService.getAppointmentByClientId(clientId).then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception("Error retrieving client's appointments: $e");
    }
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentByFreelancerId(
      String freelancerId, String? token) {
    try {
      return _hiveService
          .getAppointmentByFreelancerId(freelancerId)
          .then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception("Error retrieving education: $e");
    }
  }

  @override
  Future<AppointmentEntity> getAppointmentById(
      String appointmentId, String? token) async {
    try {
      final appointmentHiveModel = await _hiveService.getAppointmentById(appointmentId);
      return appointmentHiveModel!.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveAppointment(AppointmentEntity appointmentEntity, String? token) async {
    try {
      final appointmentHiveModel = AppointmentHiveModel.fromEntity(appointmentEntity);
      await _hiveService.saveAppointment(appointmentHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateAppointment(String appointmentId,
      AppointmentEntity updatedAppointment, String? token) async {
    try {
      final appointmentHiveModel = await _hiveService.getAppointmentById(appointmentId);

      if (appointmentHiveModel == null) {
        throw Exception("Appointment not found");
      }

      await _hiveService.updateAppointment(
        appointmentId,
        newAppointmentPurpose: updatedAppointment.appointmentPurpose
      );
    } catch (e) {
      throw Exception("Failed to update appointment data: $e");
    }
  }
}
