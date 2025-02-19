import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class GetPaymentByAppointmentIdParams {
  final String appointmentId;
  GetPaymentByAppointmentIdParams({required this.appointmentId});
}

class GetPaymentByAppointmentIdUseCase
    implements
        UsecaseWithParams<PaymentEntity, GetPaymentByAppointmentIdParams> {
  final IPaymentRepository paymentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetPaymentByAppointmentIdUseCase(
      {required this.paymentRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, PaymentEntity>> call(
      GetPaymentByAppointmentIdParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return paymentRepository.getPaymentByAppointmentId(
          params.appointmentId, r);
    });
  }
}
