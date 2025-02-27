import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

abstract interface class IPaymentRepository {
  Future<Either<Failure, void>> savePayment(PaymentEntity paymentEntity, String? token);
  Future<Either<Failure, PaymentEntity>> getPaymentByAppointmentId(String appointmentId, String? token);
  Future<Either<Failure, void>> updatePayment(String paymentId, PaymentEntity updatedPayemnt, String? token);
  Future<Either<Failure, PaymentEntity>> getPaymentById(String paymentId, String? token);
  Future<Either<Failure, void>> deletePaymentByAppointmentId(String appointmentId, String? token);
}