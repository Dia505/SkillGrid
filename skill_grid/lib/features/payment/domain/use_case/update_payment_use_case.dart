import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class UpdatePaymentParams extends Equatable {
  final String paymentId;
  final String appointmentId;
  final String? paymentMethod;

  const UpdatePaymentParams(
      {required this.paymentId,
      required this.appointmentId,
      this.paymentMethod});

  @override
  List<Object?> get props => [paymentId, appointmentId, paymentMethod];
}

class UpdatePaymentUseCase implements UsecaseWithParams<void, UpdatePaymentParams> {
  final IPaymentRepository paymentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  UpdatePaymentUseCase({
    required this.paymentRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, void>> call(UpdatePaymentParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if (role == "client") {
        final existingPayment =
            await paymentRepository.getPaymentByAppointmentId(params.appointmentId, r);
        return existingPayment.fold(
          (failure) => Left(failure),
          (currentPayment) async {
            final updatedPayment = PaymentEntity(
              paymentId: params.paymentId,
              paymentMethod: params.paymentMethod ?? currentPayment.paymentMethod, 
              paymentStatus: currentPayment.paymentStatus, 
              appointment: currentPayment.appointment, 
              billingAddress: currentPayment.billingAddress
            );
            return paymentRepository.updatePayment(
                params.appointmentId, params.paymentId, updatedPayment, r);
          },
        );
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }}
