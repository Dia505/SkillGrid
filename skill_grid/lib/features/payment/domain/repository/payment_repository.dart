import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

abstract interface class IPaymentRepository {
  Future<Either<Failure, void>> savePayment(PaymentEntity paymentEntity);
  Future<Either<Failure, PaymentEntity>> getPaymentByAppointmentId(String appointmentId, String? token);
}