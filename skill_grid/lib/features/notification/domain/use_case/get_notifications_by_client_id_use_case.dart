import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';
import 'package:skill_grid/features/notification/domain/repository/notification_repository.dart';

class GetNotificationsByClientIdParams {
  String clientId;
  GetNotificationsByClientIdParams({required this.clientId});
}

class GetNotificationsByClientIdUseCase
    implements UsecaseWithParams<List<NotificationEntity>, GetNotificationsByClientIdParams> {
  final INotificationRepository notificationRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  GetNotificationsByClientIdUseCase(
      {required this.notificationRepository,
      required this.tokenSharedPrefs,
      required this.tokenHelper});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(GetNotificationsByClientIdParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if (role == "client") {
          return notificationRepository.getNotificationsByClientId(params.clientId, r);
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }
}
