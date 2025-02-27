// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_by_appointment_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentByAppointmentIdDto _$GetPaymentByAppointmentIdDtoFromJson(
        Map<String, dynamic> json) =>
    GetPaymentByAppointmentIdDto(
      paymentId: json['_id'] as String?,
      amount: (json['amount'] as num).toInt(),
      paymentMethod: json['payment_method'] as String,
      paymentStatus: json['payment_status'] as bool,
      paymentTimestamp: json['payment_timestamp'] == null
          ? null
          : DateTime.parse(json['payment_timestamp'] as String),
      appointment: AppointmentApiModel.fromJson(
          json['appointment_id'] as Map<String, dynamic>),
      billingAddress: BillingAddressApiModel.fromJson(
          json['billing_address_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPaymentByAppointmentIdDtoToJson(
        GetPaymentByAppointmentIdDto instance) =>
    <String, dynamic>{
      '_id': instance.paymentId,
      'amount': instance.amount,
      'payment_method': instance.paymentMethod,
      'payment_status': instance.paymentStatus,
      'payment_timestamp': instance.paymentTimestamp?.toIso8601String(),
      'appointment_id': instance.appointment,
      'billing_address_id': instance.billingAddress,
    };
