part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const ResetPasswordState({required this.isLoading, required this.isSuccess});

  const ResetPasswordState.initial()
      : isLoading = false,
        isSuccess = false;

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}