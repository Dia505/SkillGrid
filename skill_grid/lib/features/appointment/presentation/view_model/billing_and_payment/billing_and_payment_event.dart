part of 'billing_and_payment_bloc.dart';

@immutable
sealed class BillingAndPaymentEvent extends Equatable {
  const BillingAndPaymentEvent();

  @override
  List<Object?> get props => [];
}

class LoadBillingDetails extends BillingAndPaymentEvent {
  final FreelancerEntity freelancerEntity;

  const LoadBillingDetails(this.freelancerEntity);
}
