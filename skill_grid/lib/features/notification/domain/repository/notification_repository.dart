import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';

abstract interface class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotificationsByClientId(String clientId, String? token);
  Future<Either<Failure, void>> markNotificationAsRead(String notificationId, String? token);
}