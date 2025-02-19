import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_hive_model.dart';
import 'package:skill_grid/features/billing_address/data/model/billing_address_hive_model.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:uuid/uuid.dart';

part 'payment_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.paymentTableId)
class PaymentHiveModel extends Equatable {
  @HiveField(0)
  final String? paymentId;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final String paymentMethod;
  @HiveField(3)
  final bool paymentStatus;
  @HiveField(4)
  final DateTime? paymentTimestamp;
  @HiveField(5)
  final AppointmentHiveModel appointment;
  @HiveField(6)
  final BillingAddressHiveModel billingAddress;

  PaymentHiveModel({
    String? paymentId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentTimestamp,
    required this.appointment,
    required this.billingAddress
  }) : paymentId = paymentId ??  const Uuid().v4();

  PaymentHiveModel.initial()
    : paymentId = "",
      amount = 0,
      paymentMethod = "",
      paymentStatus = false,
      paymentTimestamp = DateTime(1970,1,1),
      appointment = AppointmentHiveModel.initial(),
      billingAddress = const BillingAddressHiveModel.initial();

  factory PaymentHiveModel.fromEntity(PaymentEntity entity) {
    return PaymentHiveModel(
      paymentId: entity.paymentId,
      amount: entity.amount, 
      paymentMethod: entity.paymentMethod, 
      paymentStatus: entity.paymentStatus, 
      paymentTimestamp: entity.paymentTimestamp, 
      appointment: AppointmentHiveModel.fromEntity(entity.appointment), 
      billingAddress: BillingAddressHiveModel.fromEntity(entity.billingAddress)
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

  @override
  List<Object?> get props => [paymentId, amount, paymentMethod, paymentStatus, paymentTimestamp, appointment, billingAddress];
}