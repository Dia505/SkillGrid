part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetNotificationsEvent extends NotificationEvent {
  final String clientId;

  const GetNotificationsEvent(this.clientId);

  @override
  List<Object?> get props => [clientId];
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;
  final BuildContext context;

  const MarkNotificationAsReadEvent(this.notificationId, this.context);

  @override
  List<Object?> get props => [notificationId, context];
}

class NavigateToContracts extends NotificationEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToContracts({required this.context, required this.destination});
}