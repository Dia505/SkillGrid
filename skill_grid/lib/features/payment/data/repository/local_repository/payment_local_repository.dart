import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/payment/data/data_source/local_data_source/payment_local_data_source.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class PaymentLocalRepository implements IPaymentRepository {
  final PaymentLocalDataSource _paymentLocalDataSource;
  PaymentLocalRepository(
      {required PaymentLocalDataSource paymentLocalDataSource})
      : _paymentLocalDataSource = paymentLocalDataSource;

  @override
  Future<Either<Failure, PaymentEntity>> getPaymentByAppointmentId(
      String appointmentId, String? token) async {
    try {
      final paymentEntity = await _paymentLocalDataSource
          .getPaymentByAppointmentId(appointmentId, token);
      return Right(paymentEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error getting client information: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> savePayment(
      PaymentEntity paymentEntity) {
    // TODO: implement savePayment
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> updatePayment(String paymentId, PaymentEntity updatedPayemnt, String? token) {
    // TODO: implement updatePayment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PaymentEntity>> getPaymentById(String paymentId, String? token) {
    // TODO: implement getPaymentById
    throw UnimplementedError();
  }
}
