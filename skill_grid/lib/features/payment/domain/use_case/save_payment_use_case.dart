import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class SavePaymentParams {
  final int amount;
  final String paymentMethod;
  final bool paymentStatus;
  final AppointmentEntity appointment;
  final BillingAddressEntity billingAddress;

  const SavePaymentParams(
      {required this.amount,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.appointment,
      required this.billingAddress});

  SavePaymentParams.empty()
      : amount = 0,
        paymentMethod = "_empty.paymentMethod",
        paymentStatus = false,
        appointment = AppointmentEntity.empty(),
        billingAddress = const BillingAddressEntity.empty();
}

class SavePaymentUseCase implements UsecaseWithParams<void, SavePaymentParams> {
  final IPaymentRepository paymentRepository;
  SavePaymentUseCase({required this.paymentRepository});

  @override
  Future<Either<Failure, void>> call(SavePaymentParams params) async {
    return await paymentRepository.savePayment(
      PaymentEntity(
        amount: params.amount, 
        paymentMethod: params.paymentMethod, 
        paymentStatus: params.paymentStatus,
        appointment: params.appointment, 
        billingAddress: params.billingAddress
      )
    );
  }
}
