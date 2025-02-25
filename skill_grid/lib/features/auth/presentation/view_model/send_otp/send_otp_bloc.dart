import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/send_otp_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/verify_otp/verify_otp_bloc.dart';

part 'send_otp_event.dart';
part 'send_otp_state.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpBloc _verifyOtpBloc;

  SendOtpBloc({required SendOtpUseCase sendOtpUseCase, required VerifyOtpBloc verifyOtpBloc})
      : _sendOtpUseCase = sendOtpUseCase,
        _verifyOtpBloc = verifyOtpBloc,
        super(const SendOtpState.initial()) {
    on<SendEmailEvent>(_onSendEmailEvent);

    on<NavigateToVerifyOtpScreen>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: _verifyOtpBloc,
              child: event.destination),
        ),
      );
    });

    on<NavigateToLoginScreen>((event, emit) {
      final loginBloc = getIt<LoginBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: loginBloc,
              child: event.destination),
        ),
      );
    });
  }

  void _onSendEmailEvent(
    SendEmailEvent event,
    Emitter<SendOtpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _sendOtpUseCase.call(SendOtpParams(
        email: event.email));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
