import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/verify_otp_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordBloc _resetPasswordBloc;

  VerifyOtpBloc(
      {required VerifyOtpUseCase verifyOtpUseCase,
      required ResetPasswordBloc resetPasswordBloc})
      : _verifyOtpUseCase = verifyOtpUseCase,
        _resetPasswordBloc = resetPasswordBloc,
        super(const VerifyOtpState.initial()) {
    on<CheckOtpEvent>(_onCheckOtpEvent);

    on<NavigateToResetPasswodScreen>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: _resetPasswordBloc, child: event.destination),
        ),
      );
    });

    on<NavigateToLoginScreen>((event, emit) {
      final loginBloc = getIt<LoginBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: loginBloc, child: event.destination),
        ),
      );
    });
  }

  void _onCheckOtpEvent(
    CheckOtpEvent event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _verifyOtpUseCase
        .call(VerifyOtpParams(email: event.email, otp: event.otp));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
