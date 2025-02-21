import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/data/data_source/local_data_source/appointment_local_data_source.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class AppointmentLocalRepository implements IAppointmentRepository {
  final AppointmentLocalDataSource _appointmentLocalDataSource;
  AppointmentLocalRepository(
      {required AppointmentLocalDataSource appointmentLocalDataSource})
      : _appointmentLocalDataSource = appointmentLocalDataSource;

  @override
  Future<Either<Failure, void>> deleteAppointment(
      String appointmentId, String? token) async {
    try {
      await _appointmentLocalDataSource.deleteAppointment(appointmentId, token);
      return const Right(null);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: "Error deleting appointment: $e"));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByClientId(
      String clientId, String? token) async {
    try {
      final appointmentList = await _appointmentLocalDataSource
          .getAppointmentByClientId(clientId, token);
      return Right(appointmentList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final appointmentList = await _appointmentLocalDataSource
          .getAppointmentByFreelancerId(freelancerId, token);
      return Right(appointmentList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> getAppointmentById(
      String appointmentId, String? token) async {
    try {
      final appointmentEntity = await _appointmentLocalDataSource
          .getAppointmentById(appointmentId, token);
      return Right(appointmentEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error getting appointment information: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> saveAppointment(
      AppointmentEntity appointmentEntity, String? token) async {
    try {
      final appointmentId =
          await _appointmentLocalDataSource.saveAppointment(appointmentEntity, token);
      return Right(appointmentId);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppointment(String appointmentId,
      AppointmentEntity updatedAppointment, String? token) async {
    try {
      await _appointmentLocalDataSource.updateAppointment(
          appointmentId, updatedAppointment, token);
      return const Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
