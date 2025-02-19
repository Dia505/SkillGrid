import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/payment/data/data_source/remote_data_source/payment_remote_data_source.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class PaymentRemoteRepository implements IPaymentRepository {
  final PaymentRemoteDataSource _paymentRemoteDataSource;
  PaymentRemoteRepository({required PaymentRemoteDataSource paymentRemoteDataSource})
    : _paymentRemoteDataSource = paymentRemoteDataSource;

  @override
  Future<Either<Failure, PaymentEntity>> getPaymentByAppointmentId(String appointmentId, String? token) async {
    try {
      final client = await _paymentRemoteDataSource.getPaymentByAppointmentId(appointmentId, token);
      return Right(client);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePayment(PaymentEntity paymentEntity) async {
    try {
      _paymentRemoteDataSource.savePayment(paymentEntity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}