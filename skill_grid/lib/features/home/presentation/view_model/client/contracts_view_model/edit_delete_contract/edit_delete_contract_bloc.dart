import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/appointment/domain/use_case/update_appointment_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/payment/domain/use_case/delete_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/update_payment_use_case.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/review/presentation/view_model/review_bloc.dart';

part 'edit_delete_contract_event.dart';
part 'edit_delete_contract_state.dart';

class EditDeleteContractBloc
    extends Bloc<EditDeleteContractEvent, EditDeleteContractState> {
  final UpdateAppointmentUseCase _updateAppointmentUseCase;
  final UpdatePaymentUseCase _updatePaymentUseCase;
  final DeletePaymentByAppointmentIdUseCase
      _deletePaymentByAppointmentIdUseCase;
  final GetReviewByAppointmentIdUseCase _getReviewByAppointmentIdUseCase;

  EditDeleteContractBloc(
      {required UpdateAppointmentUseCase updateAppointmentUseCase,
      required UpdatePaymentUseCase updatePaymentUseCase,
      required DeletePaymentByAppointmentIdUseCase
          deletePaymentByAppointmentIdUseCase,
      required GetReviewByAppointmentIdUseCase getReviewByAppointmentIdUseCase})
      : _updateAppointmentUseCase = updateAppointmentUseCase,
        _updatePaymentUseCase = updatePaymentUseCase,
        _deletePaymentByAppointmentIdUseCase =
            deletePaymentByAppointmentIdUseCase,
        _getReviewByAppointmentIdUseCase = getReviewByAppointmentIdUseCase,
        super(EditDeleteContractInitial()) {
    on<UpdateAppointment>(_onUpdateAppointment);
    on<UpdatePayment>(_onUpdatePayment);
    on<DeletePaymentByAppointmentId>(_onDeletePaymentByAppointmentId);
    on<GetReviewByAppointmentIdEvent>(_onGetReviewByAppointmentId);

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

    on<NavigateToReview>((event, emit) {
      final reviewBloc = getIt<ReviewBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: reviewBloc, child: event.destination),
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
          appointmentPurpose: event.appointmentPurpose));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (_) async {
          emit(EditDeleteContractSuccess());

          add(NavigateToContracts(
              context: event.context,
              destination: const ClientContractsView()));

          showSnackBar(
              context: event.context,
              message: "Contract updated!",
              color: Colors.green);
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
          paymentId: event.paymentId, paymentMethod: event.paymentMethod));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (_) async {
          emit(EditDeleteContractSuccess());

          add(NavigateToContracts(
              context: event.context,
              destination: const ClientContractsView()));

          showSnackBar(
              context: event.context,
              message: "Contract updated!",
              color: Colors.green);
        },
      );
    } catch (e) {
      emit(EditDeleteContractError("Error occurred: $e"));
    }
  }

  Future<void> _onDeletePaymentByAppointmentId(
      DeletePaymentByAppointmentId event,
      Emitter<EditDeleteContractState> emit) async {
    emit(EditDeleteContractLoading());

    try {
      final result = await _deletePaymentByAppointmentIdUseCase(
          DeletePaymentByAppointmentIdParams(
              appointmentId: event.appointmentId));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (_) async {
          emit(EditDeleteContractSuccess());

          add(NavigateToContracts(
              context: event.context,
              destination: const ClientContractsView()));

          showSnackBar(
            context: event.context,
            message: "Contract deleted successfully!",
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      emit(EditDeleteContractError("Error occurred: $e"));
    }
  }

  Future<void> _onGetReviewByAppointmentId(
      GetReviewByAppointmentIdEvent event,
      Emitter<EditDeleteContractState> emit) async {
    emit(EditDeleteContractLoading());

    try {
      final result = await _getReviewByAppointmentIdUseCase(
          GetReviewByAppointmentIdParams(appointmentId: event.appointmentId));

      await result.fold(
        (failure) async => emit(EditDeleteContractError(failure.message)),
        (review) async {
          emit(EditDeleteContractSuccess());
        },
      );
    } catch (e) {
      emit(EditDeleteContractError("Error occurred: $e"));
    }
  }
}
