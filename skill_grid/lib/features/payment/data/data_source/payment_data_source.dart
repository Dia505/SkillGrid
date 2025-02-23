import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

abstract interface class IPaymentDataSource {
  Future<void> savePayment(PaymentEntity paymentEntity);
  Future<PaymentEntity> getPaymentByAppointmentId(String appointmentId, String? token);
  Future<void> updatePayment(String paymentId, String appointmentId, PaymentEntity updatedPayment, String? token);
}