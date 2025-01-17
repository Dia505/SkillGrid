import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/register_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';

part 'freelancer_event.dart';
part 'freelancer_state.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  final RegisterFreelancerUseCase _registerFreelancerUseCase;
  final LoginBloc _loginBloc;

  FreelancerBloc({
    required RegisterFreelancerUseCase registerFreelancerUseCase,
    required LoginBloc loginBloc,
  })  : _registerFreelancerUseCase = registerFreelancerUseCase,
        _loginBloc = loginBloc,
        super(FreelancerState.initial()) {
    on<RegisterFreelancer>(_onRegisterFreelancer);

    on<NavigateToLoginScreen>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: _loginBloc, child: event.destination),
        ),
      );
    });
  }

  void _onRegisterFreelancer(
    RegisterFreelancer event,
    Emitter<FreelancerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerFreelancerUseCase.call(CreateFreelancerParams(
        firstName: event.firstName,
        lastName: event.lastName,
        dateOfBirth: event.dateOfBirth,
        mobileNo: event.mobileNo,
        address: event.address,
        city: event.city,
        email: event.email,
        password: event.password));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      showSnackBar(context: event.context, message: "Registration Successful");
    });
  }
}
