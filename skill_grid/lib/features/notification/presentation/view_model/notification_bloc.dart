import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';
import 'package:skill_grid/features/notification/domain/use_case/get_notifications_by_client_id_use_case.dart';
import 'package:skill_grid/features/notification/domain/use_case/mark_notification_as_read_use_case.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsByClientIdUseCase _getNotificationsByClientIdUseCase;
  final TokenHelper _tokenHelper;
  final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;

  NotificationBloc(
      {required GetNotificationsByClientIdUseCase
          getNotificationsByClientIdUseCase,
      required TokenHelper tokenHelper,
      required MarkNotificationAsReadUseCase markNotificationAsReadUseCase})
      : _getNotificationsByClientIdUseCase = getNotificationsByClientIdUseCase,
        _tokenHelper = tokenHelper,
        _markNotificationAsReadUseCase = markNotificationAsReadUseCase,
        super(NotificationInitial()) {
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);

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

  Future<void> getClientNotifications() async {
    emit(NotificationLoading());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const NotificationError("Client id not found"));
        return;
      }

      final Either<Failure, List<NotificationEntity>> result =
          await _getNotificationsByClientIdUseCase(
              GetNotificationsByClientIdParams(clientId: userId));

      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (notifications) => emit(NotificationLoaded(notifications)),
      );
    } catch (e) {
      emit(NotificationError("Error occurred: $e"));
    }
  }

  Future<void> _onMarkNotificationAsRead(MarkNotificationAsReadEvent event,
      Emitter<NotificationState> emit) async {
    final result = await _markNotificationAsReadUseCase(
      MarkNotificationAsReadParams(notificationId: event.notificationId),
    );

    result.fold(
      (failure) {
        emit(NotificationError(failure.message));
      },
      (_) {
        emit(NotificationMarkedAsRead());
        add(NavigateToContracts(
          context: event.context,
          destination: const ClientContractsView(),
        ));
      },
    );
  }
}
