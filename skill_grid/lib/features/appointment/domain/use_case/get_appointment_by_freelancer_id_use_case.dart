import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/repository/appointment_repository.dart';

class GetAppointmentByFreelancerIdParams {
  String freelancerId;
  GetAppointmentByFreelancerIdParams({required this.freelancerId});
}

class GetAppointmentByFreelancerIdUseCase
    implements
        UsecaseWithParams<List<AppointmentEntity>,
            GetAppointmentByFreelancerIdParams> {
  final IAppointmentRepository appointmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetAppointmentByFreelancerIdUseCase(
      {required this.appointmentRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      GetAppointmentByFreelancerIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return appointmentRepository.getAppointmentByFreelancerId(
          params.freelancerId, r);
    });
  }
}
