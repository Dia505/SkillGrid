import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/repository/billing_address_repository.dart';

class SaveBillingAddressParams extends Equatable {
  final String address;
  final String city;

  const SaveBillingAddressParams({required this.address, required this.city});

  const SaveBillingAddressParams.empty()
      : address = "_empty.address",
        city = "_empty.city";

  @override
  List<Object?> get props => [address, city];
}

class SaveBillingAddressUseCase implements UsecaseWithParams<String, SaveBillingAddressParams> {
  final IBillingAddressRepository billlingAddressRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  SaveBillingAddressUseCase({
    required this.billlingAddressRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, String>> call(SaveBillingAddressParams params) async {
    final token = await tokenSharedPrefs.getToken();

    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();

      if(role == "client") {
        final billingAddressResult = await billlingAddressRepository.saveBillingAddress(
          BillingAddressEntity(address: params.address, city: params.city), 
          r
        );

        return billingAddressResult;
      } else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }}
