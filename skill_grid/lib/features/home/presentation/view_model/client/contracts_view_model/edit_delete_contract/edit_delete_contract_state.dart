part of 'edit_delete_contract_bloc.dart';

abstract class EditDeleteContractState extends Equatable {
  const EditDeleteContractState();

  @override
  List<Object?> get props => [];
}

class EditDeleteContractInitial extends EditDeleteContractState {}

class EditDeleteContractLoading extends EditDeleteContractState {}

class EditDeleteContractSuccess extends EditDeleteContractState {}

class ReviewLoadedState extends EditDeleteContractState {}

class EditDeleteContractError extends EditDeleteContractState {
  final String message;
  const EditDeleteContractError(this.message);

  @override
  List<Object?> get props => [message];
}