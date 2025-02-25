import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/save_appointment_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/get_billing_address_by_id_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/save_billing_address_use_case.dart';
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
        super(BillingAndPaymentInitial()) {
    on<SaveAppointment>((event, emit) async {
      emit(BillingAndPaymentLoading());

      final appointmentResult =
          await _saveAppointmentUseCase(event.appointmentParams);

      if (appointmentResult.isRight()) {
        final appointmentId = appointmentResult.getOrElse(() => "").toString();

        // Fetch the full AppointmentEntity using the appointment ID
        final appointmentEntityResult = await _getAppointmentByIdUseCase(
          GetAppointmentByIdParams(appointmentId: appointmentId),
        );

        appointmentEntityResult.fold(
          (failure) {
            emit(BillingAndPaymentError(failure.message));
          },
          (appointmentEntity) {
            emit(AppointmentSavedState(appointment: appointmentEntity));
          },
        );
      } else {
        emit(const BillingAndPaymentError("Failed to save appointment"));
      }
    });

    on<SaveBillingAddress>((event, emit) async {
      emit(BillingAndPaymentLoading());
      final billingAddressResult =
          await _saveBillingAddressUseCase(event.billingAddressParams);

      if (billingAddressResult.isRight()) {
        final billingAddressId =
            billingAddressResult.getOrElse(() => "").toString();

        final billingAddressEntityResult = await _getBillingAddressByIdUseCase(
          GetBillingAddressByIdParams(billingAddressId: billingAddressId),
        );

        billingAddressEntityResult.fold(
          (failure) {
            emit(BillingAndPaymentError(failure.message));
          },
          (billingAddressEntity) {
            emit(
                BillingAddressSavedState(billingAddress: billingAddressEntity));
          },
        );
      } else {
        emit(const BillingAndPaymentError("Failed to save billing address"));
      }
    });

    on<SavePayment>((event, emit) async {
      emit(BillingAndPaymentLoading());
      final paymentResult = await _savePaymentUseCase(event.paymentParams);

      if (paymentResult.isRight()) {
        emit(BillingAndPaymentSuccess());
        showSnackBar(
            context: event.context, message: "Payment set successfully!");
      } else {
        emit(const BillingAndPaymentError("Failed to save payment"));
      }
    });
  }
}
