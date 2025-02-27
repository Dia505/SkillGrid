// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_billing_address_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillingAddressByIdDto _$GetBillingAddressByIdDtoFromJson(
        Map<String, dynamic> json) =>
    GetBillingAddressByIdDto(
      billingAddressId: json['_id'] as String?,
      address: json['address'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$GetBillingAddressByIdDtoToJson(
        GetBillingAddressByIdDto instance) =>
    <String, dynamic>{
      '_id': instance.billingAddressId,
      'address': instance.address,
      'city': instance.city,
    };
