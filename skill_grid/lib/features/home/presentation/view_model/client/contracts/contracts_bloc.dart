import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final GetAppointmentByClientIdUseCase _getAppointmentByClientIdUseCase;
  final TokenHelper _tokenHelper;
  final GetPaymentByAppointmentIdUseCase _getPaymentByAppointmentIdUseCase;

  ContractsBloc(
      {required GetAppointmentByClientIdUseCase getAppointmentByClientIdUseCase,
      required TokenHelper tokenHelper,
      required GetPaymentByAppointmentIdUseCase
          getPaymentByAppointmentIdUseCase})
      : _getAppointmentByClientIdUseCase = getAppointmentByClientIdUseCase,
        _tokenHelper = tokenHelper,
        _getPaymentByAppointmentIdUseCase = getPaymentByAppointmentIdUseCase,
        super(ContractsInitialState());

  Future<void> loadClientContracts() async {
    emit(ContractsLoadingState());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const ContractsErrorState("Client id not found"));
        return;
      }

      final appointmentResult = await _getAppointmentByClientIdUseCase(
        GetAppointmentByClientIdParams(clientId: userId),
      );

      final appointments = appointmentResult.fold(
        (failure) {
          emit(ContractsErrorState(failure.message));
          return <AppointmentEntity>[];
        },
        (appointments) => appointments,
      );

      if (appointments.isEmpty) {
        emit(const ContractsErrorState("No appointments found"));
        return;
      }

      final payments = await Future.wait(appointments.map((appointment) async {
        final paymentResult = await _getPaymentByAppointmentIdUseCase(
          GetPaymentByAppointmentIdParams(
              appointmentId: appointment.appointmentId!),
        );
        return paymentResult.fold(
          (failure) => throw Exception("Failed to fetch payment"),
          (payment) => payment,
        );
      }));

      emit(ContractsLoadedState(appointments, payments));
    } catch (e) {
      emit(ContractsErrorState("Error occurred: $e"));
    }
  }
}
