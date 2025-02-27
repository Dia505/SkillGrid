import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class GetAppointmentByClientIdParams {
  String clientId;
  GetAppointmentByClientIdParams({required this.clientId});
}

class GetAppointmentByClientIdUseCase implements UsecaseWithParams<List<AppointmentEntity>, GetAppointmentByClientIdParams> {
  final IAppointmentRepository appointmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  GetAppointmentByClientIdUseCase({required this.appointmentRepository, required this.tokenSharedPrefs, required this.tokenHelper});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(GetAppointmentByClientIdParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if(role == "client") {
        return appointmentRepository.getAppointmentByClientId(
          params.clientId, r);
      } else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}