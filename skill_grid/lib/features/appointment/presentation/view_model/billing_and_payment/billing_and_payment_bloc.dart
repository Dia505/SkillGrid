import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/save_appointment_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/get_billing_address_by_id_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/save_billing_address_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/payment/domain/use_case/save_payment_use_case.dart';

part 'billing_and_payment_event.dart';
part 'billing_and_payment_state.dart';

class BillingAndPaymentBloc
    extends Bloc<BillingAndPaymentEvent, BillingAndPaymentState> {
  final SaveAppointmentUseCase _saveAppointmentUseCase;
  final SavePaymentUseCase _savePaymentUseCase;
  final SaveBillingAddressUseCase _saveBillingAddressUseCase;
  final GetAppointmentByIdUseCase _getAppointmentByIdUseCase;
  final GetBillingAddressByIdUseCase _getBillingAddressByIdUseCase;

  BillingAndPaymentBloc(
      {required SaveAppointmentUseCase saveAppointmentUseCase,
      required SavePaymentUseCase savePaymentUseCase,
      required SaveBillingAddressUseCase saveBillingAddressUseCase,
      required GetAppointmentByIdUseCase getAppointmentByIdUseCase,
      required GetBillingAddressByIdUseCase getBillingAddressByIdUseCase})
      : _saveAppointmentUseCase = saveAppointmentUseCase,
        _savePaymentUseCase = savePaymentUseCase,
        _saveBillingAddressUseCase = saveBillingAddressUseCase,
        _getAppointmentByIdUseCase = getAppointmentByIdUseCase,
        _getBillingAddressByIdUseCase = getBillingAddressByIdUseCase,
        super(const BillingAndPaymentInitial()) {
    on<SaveAppointment>(_onSaveAppointment);
    on<SaveBillingAddress>(_onSaveBillingAddress);
    on<SavePayment>(_onSavePayment);

    on<NavigateToContracts>((event, emit) {
      final clientDashboardCubit = getIt<ClientDashboardCubit>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: clientDashboardCubit..setInitialIndex(2),
              child: event.destination),
        ),
      );
    });
  }

  Future<void> _onSaveAppointment(
      SaveAppointment event, Emitter<BillingAndPaymentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final appointmentResult =
        await _saveAppointmentUseCase(event.appointmentParams);

    if (appointmentResult.isLeft()) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Failed to save appointment"));
      return;
    }

    final appointmentId = appointmentResult.getOrElse(() => "").toString();
    final appointmentEntityResult = await _getAppointmentByIdUseCase(
      GetAppointmentByIdParams(appointmentId: appointmentId),
    );

    appointmentEntityResult.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (appointmentEntity) {
        emit(state.copyWith(
          isLoading: false,
          appointment: appointmentEntity,
          errorMessage: null, // Clear previous errors
        ));
      },
    );
  }

  Future<void> _onSaveBillingAddress(
      SaveBillingAddress event, Emitter<BillingAndPaymentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final billingAddressResult =
        await _saveBillingAddressUseCase(event.billingAddressParams);

    if (billingAddressResult.isLeft()) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Failed to save billing address"));
      return;
    }

    final billingAddressId =
        billingAddressResult.getOrElse(() => "").toString();
    final billingAddressEntityResult = await _getBillingAddressByIdUseCase(
      GetBillingAddressByIdParams(billingAddressId: billingAddressId),
    );

    billingAddressEntityResult.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (billingAddressEntity) {
        emit(state.copyWith(
          isLoading: false,
          billingAddress: billingAddressEntity,
          errorMessage: null, // Clear previous errors
        ));
      },
    );
  }

  Future<void> _onSavePayment(
      SavePayment event, Emitter<BillingAndPaymentState> emit) async {
    emit(state.copyWith(isLoading: true));
    final paymentResult = await _savePaymentUseCase(event.paymentParams);
    if (paymentResult.isLeft()) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Failed to save payment"));
      return;
    }

    emit(state.copyWith(isLoading: false, errorMessage: null));

    add(NavigateToContracts(
        context: event.context, destination: const ClientDashboard()));

    showSnackBar(context: event.context, message: "Payment set successfully!");
  }
}
