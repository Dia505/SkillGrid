part of 'billing_and_payment_bloc.dart';

abstract class BillingAndPaymentState extends Equatable {
  const BillingAndPaymentState();

  @override
  List<Object?> get props => [];
}

class BillingAndPaymentInitial extends BillingAndPaymentState {}

class BillingDetailsLoaded extends BillingAndPaymentState {
  final FreelancerEntity freelancerEntity;

  BillingDetailsLoaded(this.freelancerEntity);
}