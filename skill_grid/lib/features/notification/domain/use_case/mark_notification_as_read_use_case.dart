import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/notification/domain/repository/notification_repository.dart';

class MarkNotificationAsReadParams extends Equatable {
  final String notificationId;

  const MarkNotificationAsReadParams(
      {required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class MarkNotificationAsReadUseCase
    implements UsecaseWithParams<void, MarkNotificationAsReadParams> {
  final INotificationRepository notificationRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  MarkNotificationAsReadUseCase(
      {required this.notificationRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(
      MarkNotificationAsReadParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return notificationRepository.markNotificationAsRead(
          params.notificationId, r);
    });
  }
}
