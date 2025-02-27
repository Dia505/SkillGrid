import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';

abstract interface class IAppointmentDataSource {
  Future<String> saveAppointment(AppointmentEntity appointmentEntity, String? token);
  Future<List<AppointmentEntity>> getAppointmentByFreelancerId(String freelancerId, String? token);
  Future<List<AppointmentEntity>> getAppointmentByClientId(String clientId, String? token);
  Future<AppointmentEntity> getAppointmentById(String appointmentId, String? token);
  Future<void> deleteAppointment(String appointmentId, String? token);
  Future<void> updateAppointment(String appointmentId, AppointmentEntity updatedAppointment, String? token);
}