import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class UpdateAppointmentParams extends Equatable {
  final String appointmentId;
  final String? appointmentPurpose;

  const UpdateAppointmentParams(
      {required this.appointmentId, this.appointmentPurpose});

  @override
  List<Object?> get props => [appointmentId, appointmentPurpose];
}

class UpdateAppointmentUseCase
    implements UsecaseWithParams<void, UpdateAppointmentParams> {
  final IAppointmentRepository appointmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  UpdateAppointmentUseCase(
      {required this.appointmentRepository,
      required this.tokenSharedPrefs,
      required this.tokenHelper});

  @override
  Future<Either<Failure, void>> call(UpdateAppointmentParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if (role == "client") {
        final existingAppointment =
            await appointmentRepository.getAppointmentById(params.appointmentId, r);
        return existingAppointment.fold(
          (failure) => Left(failure),
          (currentAppointment) async {
            final updatedAppointment = AppointmentEntity(
              appointmentId: params.appointmentId,
              appointmentPurpose: params.appointmentPurpose ?? currentAppointment.appointmentPurpose,
              appointmentDate: currentAppointment.appointmentDate,
              projectDuration: currentAppointment.projectDuration,
              projectEndDate: currentAppointment.projectEndDate,
              appointmentTime: currentAppointment.appointmentTime,
              status: currentAppointment.status,
              freelancerService: currentAppointment.freelancerService,
              client: currentAppointment.client
            );
            return appointmentRepository.updateAppointment(
                params.appointmentId, updatedAppointment, r);
          },
        );
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }
}
