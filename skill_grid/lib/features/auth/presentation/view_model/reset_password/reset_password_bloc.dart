import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/reset_password_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordBloc({required ResetPasswordUseCase resetPasswordUseCase})
      : _resetPasswordUseCase = resetPasswordUseCase,
        super(const ResetPasswordState.initial()) {
    on<ChangePasswordEvent>(_onChangePasswordEvent);

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

  void _onChangePasswordEvent(
    ChangePasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _resetPasswordUseCase.call(ResetPasswordParams(
      email: event.email,
      otp: event.otp,
      newPassword: event.newPassword,
    ));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      showSnackBar(context: event.context, message: "Password reset successful");
      add(NavigateToLoginScreen(
          context: event.context, destination: const LoginScreenView()));
    });
  }
}
