part of 'send_otp_bloc.dart';

class SendOtpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const SendOtpState({required this.isLoading, required this.isSuccess});

  const SendOtpState.initial()
      : isLoading = false,
        isSuccess = false;

  SendOtpState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return SendOtpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
