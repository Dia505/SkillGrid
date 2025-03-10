import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

abstract interface class IPaymentDataSource {
  Future<void> savePayment(PaymentEntity paymentEntity, String? token);
  Future<PaymentEntity> getPaymentByAppointmentId(String appointmentId, String? token);
  Future<void> updatePayment(String paymentId, PaymentEntity updatedPayment, String? token);
  Future<PaymentEntity> getPaymentById(String paymentId, String? token);
  Future<void> deletePaymentByAppointmentId(String appointmentId, String? token);
}