import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/repository/billing_address_repository.dart';

class GetBillingAddressByIdParams {
  final String billingAddressId;
  GetBillingAddressByIdParams({required this.billingAddressId});
}

class GetBillingAddressByIdUseCase implements UsecaseWithParams<BillingAddressEntity, GetBillingAddressByIdParams> {
  final IBillingAddressRepository billingAddressRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetBillingAddressByIdUseCase({required this.billingAddressRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, BillingAddressEntity>> call(GetBillingAddressByIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return billingAddressRepository.getBillingAddressById(
          params.billingAddressId, r);
    });
  }
}