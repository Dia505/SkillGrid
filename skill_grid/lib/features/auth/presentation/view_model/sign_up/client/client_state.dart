part of 'client_bloc.dart';

class ClientState {
  final bool isLoading;
  final bool isSuccess;

  ClientState({
    required this.isLoading,
    required this.isSuccess,
  });

  ClientState.initial()
    : isLoading = false,
      isSuccess = false;

  ClientState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ClientState(
      isLoading: isLoading ?? this.isLoading, 
      isSuccess: isSuccess ?? this.isSuccess
    );
  }
}