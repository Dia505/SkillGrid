import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/update_appointment_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/update_payment_use_case.dart';

part 'edit_delete_contract_event.dart';
part 'edit_delete_contract_state.dart';

class EditDeleteContractBloc
    extends Bloc<EditDeleteContractEvent, EditDeleteContractState> {
  final GetAppointmentByIdUseCase _getAppointmentByIdUseCase;
  final UpdateAppointmentUseCase _updateAppointmentUseCase;
  final GetPaymentByAppointmentIdUseCase _getPaymentByAppointmentIdUseCase;
  final UpdatePaymentUseCase _updatePaymentUseCase;

  EditDeleteContractBloc({
    required GetAppointmentByIdUseCase getAppointmentByIdUseCase,
    required UpdateAppointmentUseCase updateAppointmentUseCase,
    required GetPaymentByAppointmentIdUseCase getPaymentByAppointmentIdUseCase,
    required UpdatePaymentUseCase updatePaymentUseCase,
  })  : _getAppointmentByIdUseCase = getAppointmentByIdUseCase,
        _updateAppointmentUseCase = updateAppointmentUseCase,
        _getPaymentByAppointmentIdUseCase = getPaymentByAppointmentIdUseCase,
        _updatePaymentUseCase = updatePaymentUseCase,
        super(EditDeleteContractInitial()) {
    on<UpdateAppointment>(_onUpdateAppointment);
    on<UpdatePayment>(_onUpdatePayment);

    on<NavigateToContracts>((event, emit) {
      final contractsBloc = getIt<ContractsBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: contractsBloc, child: event.destination),
        ),
      );
    });
  }

  void _onUpdateAppointment(
      UpdateAppointment event, Emitter<EditDeleteContractState> emit) async {
    emit(EditDeleteContractLoading());

    try {
      final result = await _updateAppointmentUseCase(UpdateAppointmentParams(
        appointmentId: event.appointmentId,
        appointmentPurpose: event.appointmentPurpose
      ));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (_) async {
          emit(EditDeleteContractSuccess());

          add(NavigateToContracts(context: event.context, destination: const ClientContractsView()));

          showSnackBar(
            context: event.context, 
            message: "Contract updated!",
            color: Colors.green
          );
        },
      );
    } catch (e) {
      emit(EditDeleteContractError("Error occurred: $e"));
    }
  }

  void _onUpdatePayment(
      UpdatePayment event, Emitter<EditDeleteContractState> emit) async {
    emit(EditDeleteContractLoading());

    try {
      final result = await _updatePaymentUseCase(UpdatePaymentParams(
        paymentId: event.paymentId, 
        appointmentId: event.appointmentId,
        paymentMethod: event.paymentMethod
      ));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (_) async {
          emit(EditDeleteContractSuccess());

          add(NavigateToContracts(context: event.context, destination: const ClientContractsView()));

          showSnackBar(
            context: event.context, 
            message: "Contract updated!",
            color: Colors.green
          );
        },
      );
    } catch (e) {
      emit(EditDeleteContractError("Error occurred: $e"));
    }
  }
}
