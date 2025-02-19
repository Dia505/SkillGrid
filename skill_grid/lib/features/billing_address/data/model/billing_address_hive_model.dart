import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:uuid/uuid.dart';

part 'billing_address_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.billingAddressTableId)
class BillingAddressHiveModel extends Equatable {
  @HiveField(0)
  final String? billingAddressId;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final String city;

  BillingAddressHiveModel(
      {String? billingAddressId, required this.address, required this.city})
      : billingAddressId = billingAddressId ?? const Uuid().v4();

  const BillingAddressHiveModel.initial()
      : billingAddressId = "",
        address = "",
        city = "";

  factory BillingAddressHiveModel.fromEntity(BillingAddressEntity entity) {
    return BillingAddressHiveModel(
      billingAddressId: entity.billingAddressId,
      address: entity.address, 
      city: entity.city
    );
  }

  BillingAddressEntity toEntity() {
    return BillingAddressEntity(
      billingAddressId: billingAddressId,
      address: address, 
      city: city
    );
  }

  @override
  List<Object?> get props => [billingAddressId, address, city];
}
