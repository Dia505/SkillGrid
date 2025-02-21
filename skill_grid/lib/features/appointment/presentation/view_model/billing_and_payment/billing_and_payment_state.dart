part of 'billing_and_payment_bloc.dart';

class BillingAndPaymentState extends Equatable {
  const BillingAndPaymentState();
  
  @override
  List<Object?> get props => [];
}

class BillingAndPaymentInitial extends BillingAndPaymentState {}

class BillingAndPaymentLoading extends BillingAndPaymentState {}

class BillingAndPaymentSuccess extends BillingAndPaymentState {}

class BillingAndPaymentError extends BillingAndPaymentState {
  final String message;
  const BillingAndPaymentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AppointmentSavedState extends BillingAndPaymentState {
  final AppointmentEntity appointment;
  const AppointmentSavedState({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class BillingAddressSavedState extends BillingAndPaymentState {
  final BillingAddressEntity billingAddress;
  const BillingAddressSavedState({required this.billingAddress});

  @override
  List<Object?> get props => [billingAddress];
}



