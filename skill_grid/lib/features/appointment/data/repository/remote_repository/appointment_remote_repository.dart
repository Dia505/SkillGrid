import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/data/data_source/remote_data_source/appointment_remote_data_source.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class AppointmentRemoteRepository implements IAppointmentRepository {
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;
  AppointmentRemoteRepository({required AppointmentRemoteDataSource appointmentRemoteDataSource})
    : _appointmentRemoteDataSource = appointmentRemoteDataSource;

  @override
  Future<Either<Failure, void>> deleteAppointment(String appointmentId, String? token) async {
    try {
      _appointmentRemoteDataSource.deleteAppointment(appointmentId, token);
      return Right(null);
    }
    catch(e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByClientId(String clientId, String? token) async {
    try {
      final appointmentList = await _appointmentRemoteDataSource
          .getAppointmentByClientId(clientId, token);
      return Right(appointmentList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointmentByFreelancerId(String freelancerId, String? token) async {
    try {
      final appointmentList = await _appointmentRemoteDataSource
          .getAppointmentByFreelancerId(freelancerId, token);
      return Right(appointmentList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> getAppointmentById(String appointmentId, String? token) async {
    try {
      final appointment = await _appointmentRemoteDataSource.getAppointmentById(appointmentId, token);
      return Right(appointment);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveAppointment(AppointmentEntity appointmentEntity, String? token) async {
    try {
      _appointmentRemoteDataSource.saveAppointment(appointmentEntity, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppointment(String appointmentId, AppointmentEntity updatedAppointment, String? token) async {
    try {
      await _appointmentRemoteDataSource.updateAppointment(appointmentId, updatedAppointment, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}