import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/billing_address/data/model/billing_address_api_model.dart';

part 'get_payment_by_appointment_id_dto.g.dart';

@JsonSerializable()
class GetPaymentByAppointmentIdDto {
  @JsonKey(name: '_id')
  final String? paymentId;
  final int amount;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'payment_status')
  final bool paymentStatus;
  @JsonKey(name: 'payment_timestamp')
  final DateTime? paymentTimestamp;
  @JsonKey(name: 'appointment_id')
  final AppointmentApiModel appointment;
  @JsonKey(name: 'billing_address_id')
  final BillingAddressApiModel billingAddress;

  const GetPaymentByAppointmentIdDto({
    this.paymentId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentTimestamp,
    required this.appointment,
    required this.billingAddress
  });

  factory GetPaymentByAppointmentIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentByAppointmentIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetPaymentByAppointmentIdDtoToJson(this);
}