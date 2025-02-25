import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/review/domain/use_case/save_review_use_case.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final SaveReviewUseCase _saveReviewUseCase;
  final TokenHelper _tokenHelper;
  final GetClientByIdUseCase _getClientByIdUseCase;

  ReviewBloc(
      {required SaveReviewUseCase saveReviewUseCase,
      required TokenHelper tokenHelper,
      required GetClientByIdUseCase getClientByIdUseCase})
      : _saveReviewUseCase = saveReviewUseCase,
        _tokenHelper = tokenHelper,
        _getClientByIdUseCase = getClientByIdUseCase,
        super(ReviewInitial()) {
    on<FetchClientData>(_onFetchClientData);
    on<SaveReview>(_onSaveReview);

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

  Future<void> _onFetchClientData(
      FetchClientData event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());

    final userId = await _tokenHelper.getUserIdFromToken();
    if (userId == null) {
      emit(const ReviewError("User not logged in"));
      return;
    }

    final Either<Failure, ClientEntity> clientResult =
        await _getClientByIdUseCase.call(GetClientByIdParams(clientId: userId));

    clientResult.fold(
      (failure) => emit(ReviewError(failure.message)),
      (client) => emit(ClientFetched(client: client)),
    );
  }

  Future<void> _onSaveReview(
      SaveReview event, Emitter<ReviewState> emit) async {
    final currentState = state;
    if (currentState is! ClientFetched) {
      emit(const ReviewError("Client data not available"));
      return;
    }

    emit(ReviewLoading());

    try {
      final client = currentState.client;

      final result = await _saveReviewUseCase(SaveReviewParams(
        review: event.review,
        rating: event.rating,
        reviewDate: event.reviewDate,
        client: client,
        freelancer: event.freelancer,
        appointment: event.appointment,
      ));

      result.fold(
        (failure) => emit(ReviewError(failure.message)),
        (_) {
          emit(ReviewSuccess());

          add(NavigateToContracts(
              context: event.context, destination: const ClientDashboard()));

          showSnackBar(
              context: event.context,
              message: "Review written successfully",
              color: Colors.green);
        },
      );
    } catch (e) {
      emit(ReviewError("Error occurred: $e"));
    }
  }
}
