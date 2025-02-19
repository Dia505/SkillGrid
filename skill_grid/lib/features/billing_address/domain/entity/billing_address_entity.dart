import 'package:equatable/equatable.dart';

class BillingAddressEntity extends Equatable {
  final String? billingAddressId;
  final String address;
  final String city;

  const BillingAddressEntity({
    this.billingAddressId,
    required this.address,
    required this.city
  });

  const BillingAddressEntity.empty()
    : billingAddressId = "_empty.billingAddressId",
      address = "_empty.address",
      city = "_empty.city";

  @override
  List<Object?> get props => [billingAddressId, address, city];
}