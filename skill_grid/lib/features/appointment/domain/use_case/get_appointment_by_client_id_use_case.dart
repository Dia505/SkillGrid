import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/network/network_info.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class GetAppointmentByClientIdParams {
  String clientId;
  GetAppointmentByClientIdParams({required this.clientId});
}

class GetAppointmentByClientIdUseCase
    implements
        UsecaseWithParams<List<AppointmentEntity>,
            GetAppointmentByClientIdParams> {
  final IAppointmentRepository remoteAppointmentRepository;
  final IAppointmentRepository localAppointmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;
  final NetworkInfo networkInfo;

  GetAppointmentByClientIdUseCase(
      {required this.remoteAppointmentRepository,
      required this.localAppointmentRepository,
      required this.tokenSharedPrefs,
      required this.tokenHelper,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      GetAppointmentByClientIdParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if (role == "client") {
        if (await networkInfo.isConnected) {
          final result = await remoteAppointmentRepository
              .getAppointmentByClientId(params.clientId, r);
          result.fold((failure) => null, (appointments) async {
            // appointments is a List<AppointmentEntity>
            for (var appointment in appointments) {
              var val= localAppointmentRepository.saveAppointment(
                  appointment, r); // Save each appointment to local Hive
              print('LOCALL $val');
              return val;
            }
          });
          return result;
        } else {
          return localAppointmentRepository.getAppointmentByClientId(
              params.clientId, r);
        }
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }
}
