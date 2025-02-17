import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';

part 'freelancer_profile_event.dart';
part 'freelancer_profile_state.dart';

class FreelancerProfileBloc extends Bloc<FreelancerProfileEvent, FreelancerProfileState> {
  final GetFreelancerByIdUseCase _getFreelancerByIdUseCase;

  FreelancerProfileBloc({
    required GetFreelancerByIdUseCase getFreelancerByIdUseCase
  })  : _getFreelancerByIdUseCase = getFreelancerByIdUseCase,
        super(FreelancerProfileInitial()){
    on<FetchFreelancerDetails>(_onFetchFreelancerDetails);
  }

  Future<void> _onFetchFreelancerDetails(
      FetchFreelancerDetails event, Emitter<FreelancerProfileState> emit) async {
    emit(FreelancerProfileLoading());
    
    final result = await _getFreelancerByIdUseCase(
      GetFreelancerByIdParams(freelancerId: event.freelancerId),
    );

    result.fold(
      (failure) => emit(FreelancerProfileError(failure.message)),
      (freelancer) => emit(FreelancerProfileLoaded(freelancer)),
    );
  }
}