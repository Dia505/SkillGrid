import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';

part 'send_an_offer_event.dart';
part 'send_an_offer_state.dart';

class SendAnOfferBloc extends Bloc<SendAnOfferEvent, SendAnOfferState> {
  final GetFreelancerByIdUseCase _getFreelancerByIdUseCase;
  final GetFreelancerServiceByFreelancerIdUseCase
      _getFreelancerServiceByFreelancerIdUseCase;

  SendAnOfferBloc({
    required GetFreelancerByIdUseCase getFreelancerByIdUseCase,
    required GetFreelancerServiceByFreelancerIdUseCase
        getFreelancerServiceByFreelancerIdUseCase,
  })  : _getFreelancerByIdUseCase = getFreelancerByIdUseCase,
        _getFreelancerServiceByFreelancerIdUseCase =
            getFreelancerServiceByFreelancerIdUseCase,
        super(SendAnOfferInitial()) {
    on<FetchFreelancerDetailsEvent>(_onFetchFreelancerDetails);

    on<FillAppointmentDetailsEvent>((event, emit) {
      emit(AppointmentDetailsFilled(event.appointmentEntity));
    });

    on<NavigateToFreelancerProfile>((event, emit) {
      final freelancerProfileBloc = getIt<FreelancerProfileBloc>();

      Navigator.pushReplacement(
        event.context, 
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: freelancerProfileBloc,
            child: event.destination,
          )
        )
      );
    });
  }

  Future<void> _onFetchFreelancerDetails(
      FetchFreelancerDetailsEvent event, Emitter<SendAnOfferState> emit) async {
    emit(FreelancerProfileLoading());

    final freelancerResult = await _getFreelancerByIdUseCase(
      GetFreelancerByIdParams(freelancerId: event.freelancerId),
    );

    final freelancer = freelancerResult.fold(
      (failure) {
        emit(SendAnOfferError(failure.message));
        return null;
      },
      (freelancer) => freelancer,
    );

    if (freelancer == null) return;

    // Fetch services
    final servicesResult = await _getFreelancerServiceByFreelancerIdUseCase(
      GetFreelancerServiceByFreelancerIdParams(
          freelancerId: event.freelancerId),
    );

    final services = servicesResult.fold(
      (failure) {
        emit(SendAnOfferError(failure.message));
        return null;
      },
      (services) => services,
    );

    if (services == null) return;

    emit(FreelancerProfileLoaded(freelancer, services));
  }
}
