import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/billing_address/data/data_source/remote_data_source.dart/billing_address_remote_data_source.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/repository/billing_address_repository.dart';

class BillingAddressRemoteRepository implements IBillingAddressRepository {
  final BillingAddressRemoteDataSource _billingAddressRemoteDataSource;
  BillingAddressRemoteRepository({required BillingAddressRemoteDataSource billingAddressRemoteDataSource})
    : _billingAddressRemoteDataSource = billingAddressRemoteDataSource;

  @override
  Future<Either<Failure, String>> saveBillingAddress(BillingAddressEntity billingAddressEntity, String? token) async {
    try {
      final billingAddressId = await _billingAddressRemoteDataSource.saveBillingAddress(billingAddressEntity, token);
      return Right(billingAddressId);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, BillingAddressEntity>> getBillingAddressById(String billingAddressId, String? token) async {
    try {
      final billingAddress = await _billingAddressRemoteDataSource.getBillingAddressById(
          billingAddressId, token);
      return Right(billingAddress);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}