import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

abstract interface class IBillingAddressRepository {
  Future<Either<Failure, String>> saveBillingAddress(BillingAddressEntity billingAddressEntity, String? token);
  Future<Either<Failure, BillingAddressEntity>> getBillingAddressById(String billingAddressId, String? token);
}