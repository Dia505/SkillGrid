part of 'contracts_bloc.dart';

@immutable 
sealed class ContractsEvent extends Equatable {
  const ContractsEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToEditDeleteContract extends ContractsEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToEditDeleteContract(
      {required this.context, required this.destination});
}