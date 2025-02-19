import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

abstract interface class IBillingAddressDataSource {
  Future<void> saveBillingAddress(BillingAddressEntity billingAddressEntity, String? token);
}