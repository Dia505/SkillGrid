import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';

abstract interface class IAppointmentRepository {
  Future<Either<Failure, void>> saveAppointment(AppointmentEntity appointmentEntity, String? token);
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByFreelancerId(String freelancerId, String? token);
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByClientId(String clientId, String? token);
  Future<Either<Failure, AppointmentEntity>> getAppointmentById(String appointmentId, String? token);
  Future<Either<Failure, void>> deleteAppointment(String appointmentId, String? token);
  Future<Either<Failure, void>> updateAppointment(String appointmentId, AppointmentEntity updatedAppointment, String? token);
}