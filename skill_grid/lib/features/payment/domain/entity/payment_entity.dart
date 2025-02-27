import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

class PaymentEntity extends Equatable {
  final String? paymentId;
  final int amount;
  final String paymentMethod;
  final bool paymentStatus;
  final DateTime? paymentTimestamp;
  final AppointmentEntity appointment;
  final BillingAddressEntity billingAddress;

  const PaymentEntity({
    this.paymentId,
    this.amount = 0,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentTimestamp,
    required this.appointment,
    required this.billingAddress
  });

  @override
  List<Object?> get props => [paymentId, amount, paymentMethod, paymentStatus, paymentTimestamp, appointment, billingAddress];
}