import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

abstract interface class IBillingAddressDataSource {
  Future<String> saveBillingAddress(BillingAddressEntity billingAddressEntity, String? token);
  Future<BillingAddressEntity> getBillingAddressById(String billingAddressId, String? token);
}