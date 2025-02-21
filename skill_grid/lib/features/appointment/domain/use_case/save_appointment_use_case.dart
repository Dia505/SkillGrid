import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

class SaveAppointmentParams {
  final String appointmentPurpose;
  final DateTime appointmentDate;
  final ProjectDuration projectDuration;
  final String? appointmentTime;
  final bool status;
  final FreelancerServiceEntity freelancerService;
  final ClientEntity client;

  SaveAppointmentParams({
    required this.appointmentPurpose,
    required this.appointmentDate,
    required this.projectDuration,
    this.appointmentTime,
    required this.status,
    required this.freelancerService, 
    required this.client
  });
}

class SaveAppointmentUseCase implements UsecaseWithParams<String, SaveAppointmentParams> {
  final IAppointmentRepository appointmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  SaveAppointmentUseCase({
    required this.appointmentRepository,
    required this.tokenSharedPrefs, 
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, String>> call(SaveAppointmentParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if(role == "client") {
        final appointmentResult = await appointmentRepository.saveAppointment(
          AppointmentEntity(
            appointmentPurpose: params.appointmentPurpose, 
            appointmentDate: params.appointmentDate, 
            projectDuration: params.projectDuration, 
            status: params.status, 
            appointmentTime: params.appointmentTime,
            freelancerService: params.freelancerService, 
            client: params.client
          ), 
          r
        );

        return appointmentResult;
      } else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}