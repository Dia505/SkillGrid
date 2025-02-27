import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/presentation/view/billing_and_payment_view.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/billing_and_payment/billing_and_payment_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
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
  final TokenHelper _tokenHelper;
  final GetClientByIdUseCase _getClientByIdUseCase;

  SendAnOfferBloc({
    required GetFreelancerByIdUseCase getFreelancerByIdUseCase,
    required GetFreelancerServiceByFreelancerIdUseCase
        getFreelancerServiceByFreelancerIdUseCase,
    required TokenHelper tokenHelper,
    required GetClientByIdUseCase getClientByIdUseCase
  })  : _getFreelancerByIdUseCase = getFreelancerByIdUseCase,
        _getFreelancerServiceByFreelancerIdUseCase =
            getFreelancerServiceByFreelancerIdUseCase,
        _tokenHelper = tokenHelper,
        _getClientByIdUseCase = getClientByIdUseCase,
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
                  )));
    });

    on<NavigateToBillingAndPayment>((event, emit) {
      final billingAndPaymentBloc = getIt<BillingAndPaymentBloc>();

      Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: billingAndPaymentBloc,
                    child: BillingAndPaymentView(
                      freelancer: event.freelancerEntity,
                      appointment: event.appointmentEntity,
                    ),
                  )));
    });
  }

  Future<void> _onFetchFreelancerDetails(
      FetchFreelancerDetailsEvent event, Emitter<SendAnOfferState> emit) async {
    emit(FreelancerProfileLoading());

    final clientId = await _tokenHelper.getUserIdFromToken();

    if (clientId == null) {
      emit(const SendAnOfferError("Client not authenticated"));
      return;
    }

    final clientResult = await _getClientByIdUseCase(
      GetClientByIdParams(clientId: clientId)
    );

    final client = clientResult.fold(
      (failure) {
        emit(SendAnOfferError(failure.message));
        return null;
      },
      (client) => client
    );

    if (client == null) return;

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

    emit(FreelancerProfileLoaded(freelancer, services, client));
  }
}
