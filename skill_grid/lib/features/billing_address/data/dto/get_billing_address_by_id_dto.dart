import 'package:json_annotation/json_annotation.dart';

part 'get_billing_address_by_id_dto.g.dart';

@JsonSerializable()
class GetBillingAddressByIdDto {
  @JsonKey(name: '_id')
  final String? billingAddressId;
  final String address;
  final String city;

  GetBillingAddressByIdDto({
    this.billingAddressId, required this.address, required this.city
  });

  factory GetBillingAddressByIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetBillingAddressByIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillingAddressByIdDtoToJson(this);
}