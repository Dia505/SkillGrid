import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

part 'billing_and_payment_event.dart';
part 'billing_and_payment_state.dart';

class BillingAndPaymentBloc extends Bloc<BillingAndPaymentEvent, BillingAndPaymentState> {
  BillingAndPaymentBloc() : super(BillingAndPaymentInitial()) {
    on<LoadBillingDetails>((event, emit) {
      emit(BillingDetailsLoaded(event.freelancerEntity));
    });
  }
}