import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/billing_address/data/model/billing_address_api_model.dart';
import 'package:skill_grid/features/payment/data/dto/get_payment_by_appointment_id_dto.dart';
import 'package:skill_grid/features/payment/data/dto/get_payment_by_id_dto.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

part 'payment_api_model.g.dart';

@JsonSerializable()
class PaymentApiModel extends Equatable {
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

  const PaymentApiModel({
    this.paymentId,
    required this.amount,
    required this.paymentMethod,
    required bool paymentStatus,
    DateTime? paymentTimestamp,
    required this.appointment,
    required this.billingAddress
  }) : paymentStatus = false,
      paymentTimestamp = null;

  factory PaymentApiModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentApiModelToJson(this);

  factory PaymentApiModel.fromEntity(PaymentEntity entity) {
    return PaymentApiModel(
      paymentId: entity.paymentId,
      amount: entity.amount, 
      paymentMethod: entity.paymentMethod, 
      paymentStatus: entity.paymentStatus, 
      paymentTimestamp: entity.paymentTimestamp, 
      appointment: AppointmentApiModel.fromEntity(entity.appointment), 
      billingAddress: BillingAddressApiModel.fromEntity(entity.billingAddress)
    );
  }

  PaymentEntity toEntity() {
    return PaymentEntity(
      paymentId: paymentId,
      amount: amount, 
      paymentMethod: paymentMethod, 
      paymentStatus: paymentStatus, 
      paymentTimestamp: paymentTimestamp,
      appointment: appointment.toEntity(), 
      billingAddress: billingAddress.toEntity()
    );
  }

  static PaymentEntity getPaymentByAppointmentIdDtoToEntity(GetPaymentByAppointmentIdDto dto) {
    return PaymentEntity(
      paymentId: dto.paymentId,
      amount: dto.amount, 
      paymentMethod: dto.paymentMethod, 
      paymentStatus: dto.paymentStatus, 
      paymentTimestamp: dto.paymentTimestamp,
      appointment: dto.appointment.toEntity(), 
      billingAddress: dto.billingAddress.toEntity()
    );
  }

  static PaymentEntity getPaymentByIdDtoToEntity(GetPaymentByIdDto dto) {
    return PaymentEntity(
      paymentId: dto.paymentId,
      amount: dto.amount, 
      paymentMethod: dto.paymentMethod, 
      paymentStatus: dto.paymentStatus, 
      paymentTimestamp: dto.paymentTimestamp,
      appointment: dto.appointment.toEntity(), 
      billingAddress: dto.billingAddress.toEntity()
    );
  }

  @override
  List<Object?> get props => [paymentId, amount, paymentMethod, paymentStatus, paymentTimestamp, appointment, billingAddress];
}