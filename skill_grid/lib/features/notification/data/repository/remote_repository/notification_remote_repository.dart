import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/notification/data/data_source/remote_data_source/notification_remote_data_source.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';
import 'package:skill_grid/features/notification/domain/repository/notification_repository.dart';

class NotificationRemoteRepository implements INotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;
  NotificationRemoteRepository(
      {required NotificationRemoteDataSource notificationRemoteDataSource})
      : _notificationRemoteDataSource = notificationRemoteDataSource;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotificationsByClientId(
      String clientId, String? token) async {
    try {
      final notificationList = await _notificationRemoteDataSource
          .getNotificationsByClientId(clientId, token);
      return Right(notificationList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationAsRead(
      String notificationId, String? token) async {
    try {
      await _notificationRemoteDataSource.markNotificationAsRead(
          notificationId, token);
      return const Right(null);
    } catch (e) {
      print("Error in repository: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
