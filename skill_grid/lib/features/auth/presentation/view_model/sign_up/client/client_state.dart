part of 'client_bloc.dart';

class ClientState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const ClientState({required this.isLoading, required this.isSuccess});

  const ClientState.initial()
      : isLoading = false,
        isSuccess = false;

  ClientState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ClientState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
