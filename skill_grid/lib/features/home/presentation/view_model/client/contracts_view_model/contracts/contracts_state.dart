part of 'contracts_bloc.dart';

abstract class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object?> get props => [];
}

class ContractsInitialState extends ContractsState {}

class ContractsLoadingState extends ContractsState {}

class ContractsLoadedState extends ContractsState {
  final List<AppointmentEntity> appointments;
  final List<PaymentEntity> payments;

  const ContractsLoadedState(this.appointments, this.payments);

  @override
  List<Object?> get props => [appointments, payments];
}

class ContractsErrorState extends ContractsState {
  final String message;
  const ContractsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
