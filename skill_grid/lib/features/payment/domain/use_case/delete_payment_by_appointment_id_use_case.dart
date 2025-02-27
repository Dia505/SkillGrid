import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/payment/domain/repository/payment_repository.dart';

class DeletePaymentByAppointmentIdParams extends Equatable {
  final String appointmentId;
  const DeletePaymentByAppointmentIdParams({required this.appointmentId});
  const DeletePaymentByAppointmentIdParams.empty()
      : appointmentId = '_empty.appointmentId';

  @override
  List<Object?> get props => [appointmentId];
}

class DeletePaymentByAppointmentIdUseCase implements UsecaseWithParams<void, DeletePaymentByAppointmentIdParams> {
  final IPaymentRepository paymentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  DeletePaymentByAppointmentIdUseCase({
    required this.paymentRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, void>> call(DeletePaymentByAppointmentIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if (role == "client") {
        return await paymentRepository.deletePaymentByAppointmentId(params.appointmentId, r);
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }
}
