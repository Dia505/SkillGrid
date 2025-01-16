import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/register_freelancer_use_case.dart';

part 'freelancer_event.dart';
part 'freelancer_state.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  final RegisterFreelancerUseCase _registerFreelancerUseCase;

  FreelancerBloc({
    required RegisterFreelancerUseCase registerFreelancerUseCase
  }): _registerFreelancerUseCase = registerFreelancerUseCase,
      super(FreelancerState.initial()) {
        on<RegisterFreelancer>(_onRegisterFreelancer);
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
      password: event.password
    ));
    
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showSnackBar(
          context: event.context, 
          message: "Registration Successful"
        );
      }
    );
  }
}