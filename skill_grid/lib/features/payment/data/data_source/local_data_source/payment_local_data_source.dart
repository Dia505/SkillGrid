import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/payment/data/data_source/payment_data_source.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

class PaymentLocalDataSource implements IPaymentDataSource {
  final HiveService _hiveService;
  PaymentLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<PaymentEntity> getPaymentByAppointmentId(String appointmentId, String? token) async {
    try {
      final paymentHiveModel = await _hiveService.getPaymentByAppointmentId(appointmentId);
      return paymentHiveModel.toEntity();
    }
    catch (e) {
      throw Exception("Error retrieving the appointment's payment details: $e");
    }
  }

  @override
  Future<void> savePayment(PaymentEntity paymentEntity, String? token) {
    // TODO: implement savePayment
    throw UnimplementedError();
  }
  
  @override
  Future<void> updatePayment(String paymentId, PaymentEntity updatedPayment, String? token) {
    // TODO: implement updatePayment
    throw UnimplementedError();
  }
  
  @override
  Future<PaymentEntity> getPaymentById(String paymentId, String? token) {
    // TODO: implement getPaymentById
    throw UnimplementedError();
  }

  @override
  Future<void> deletePaymentByAppointmentId(String appointmentId, String? token) {
    // TODO: implement deletePaymentByAppointmentId
    throw UnimplementedError();
  }
}