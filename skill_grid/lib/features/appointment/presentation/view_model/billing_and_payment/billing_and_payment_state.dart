part of 'billing_and_payment_bloc.dart';

class BillingAndPaymentState extends Equatable {
  final AppointmentEntity? appointment;
  final BillingAddressEntity? billingAddress;
  final bool isLoading;
  final String? errorMessage;

  const BillingAndPaymentState({
    this.appointment,
    this.billingAddress,
    this.isLoading = false,
    this.errorMessage,
  });

  BillingAndPaymentState copyWith({
    AppointmentEntity? appointment,
    BillingAddressEntity? billingAddress,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BillingAndPaymentState(
      appointment: appointment ?? this.appointment,
      billingAddress: billingAddress ?? this.billingAddress,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [appointment, billingAddress, isLoading, errorMessage];
}

// Initial State
class BillingAndPaymentInitial extends BillingAndPaymentState {
  const BillingAndPaymentInitial() : super(isLoading: false);
}

// Loading State
class BillingAndPaymentLoading extends BillingAndPaymentState {
  const BillingAndPaymentLoading() : super(isLoading: true);
}

// Success State (Retains appointment & billing address)
class BillingAndPaymentSuccess extends BillingAndPaymentState {
  const BillingAndPaymentSuccess({
    super.appointment,
    super.billingAddress,
  });
}

// Error State
class BillingAndPaymentError extends BillingAndPaymentState {
  const BillingAndPaymentError(String message)
      : super(errorMessage: message, isLoading: false);
}
