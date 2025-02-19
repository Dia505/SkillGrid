// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_address_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingAddressApiModel _$BillingAddressApiModelFromJson(
        Map<String, dynamic> json) =>
    BillingAddressApiModel(
      billingAddressId: json['_id'] as String?,
      address: json['address'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$BillingAddressApiModelToJson(
        BillingAddressApiModel instance) =>
    <String, dynamic>{
      '_id': instance.billingAddressId,
      'address': instance.address,
      'city': instance.city,
    };
