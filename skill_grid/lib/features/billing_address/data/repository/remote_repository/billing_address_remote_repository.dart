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
  Future<Either<Failure, void>> saveBillingAddress(BillingAddressEntity billingAddressEntity, String? token) async {
    try {
      _billingAddressRemoteDataSource.saveBillingAddress(billingAddressEntity, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}