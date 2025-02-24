part of 'edit_delete_contract_bloc.dart';

@immutable
sealed class EditDeleteContractEvent extends Equatable {
  const EditDeleteContractEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAppointment extends EditDeleteContractEvent {
  final String appointmentId;
  final String? appointmentPurpose;
  final BuildContext context;

  const UpdateAppointment(
      {required this.appointmentId,
      this.appointmentPurpose,
      required this.context});

  @override
  List<Object?> get props => [appointmentId, appointmentPurpose, context];
}

class UpdatePayment extends EditDeleteContractEvent {
  final String paymentId;
  final String appointmentId;
  final String? paymentMethod;
  final BuildContext context;

  const UpdatePayment(
      {required this.paymentId,
      required this.appointmentId,
      this.paymentMethod,
      required this.context});

  @override
  List<Object?> get props => [paymentId, paymentMethod, context];
}

class NavigateToContracts extends EditDeleteContractEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToContracts({required this.context, required this.destination});
}

class DeletePaymentByAppointmentId extends EditDeleteContractEvent {
  final String appointmentId;
  final BuildContext context;

  const DeletePaymentByAppointmentId({required this.appointmentId, required this.context});

  @override
  List<Object?> get props => [appointmentId, context];
}

class NavigateToReview extends EditDeleteContractEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToReview({required this.context, required this.destination});
}