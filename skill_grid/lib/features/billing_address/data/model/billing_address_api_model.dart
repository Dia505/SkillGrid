import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

part 'billing_address_api_model.g.dart';

@JsonSerializable()
class BillingAddressApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? billingAddressId;
  final String address;
  final String city;

  const BillingAddressApiModel(
      {this.billingAddressId, required this.address, required this.city});
  
  factory BillingAddressApiModel.fromJson(Map<String, dynamic> json) =>
      _$BillingAddressApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillingAddressApiModelToJson(this);

  factory BillingAddressApiModel.fromEntity(BillingAddressEntity entity) {
    return BillingAddressApiModel(
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
