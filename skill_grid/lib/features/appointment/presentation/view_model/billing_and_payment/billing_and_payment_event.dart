part of 'billing_and_payment_bloc.dart';

@immutable
sealed class BillingAndPaymentEvent extends Equatable {
  const BillingAndPaymentEvent();

  @override
  List<Object?> get props => [];
}

class SaveAppointment extends BillingAndPaymentEvent {
  final SaveAppointmentParams appointmentParams;
  final BuildContext context;

  const SaveAppointment(
      {required this.appointmentParams,
      required this.context});
}

class SavePayment extends BillingAndPaymentEvent {
  final SavePaymentParams paymentParams;
  final BuildContext context;

  const SavePayment({required this.paymentParams, required this.context});
}

class SaveBillingAddress extends BillingAndPaymentEvent {
  final SaveBillingAddressParams billingAddressParams;
  final BuildContext context;

  const SaveBillingAddress(
      {required this.billingAddressParams, required this.context});
}
