import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';

abstract interface class INotificationDataSource {
  Future<List<NotificationEntity>> getNotificationsByClientId(String clientId, String? token);
  Future<void> markNotificationAsRead(String notificationId, String? token);
}