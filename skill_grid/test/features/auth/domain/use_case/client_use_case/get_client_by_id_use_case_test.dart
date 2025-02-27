import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';

import '../mock_token_helper.mock.dart';
import '../mock_token_shared_prefs.mock.dart';
import 'mock_client_repository.mock.dart';

void main() {
  late MockClientRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late MockTokenHelper tokenHelper;
  late GetClientByIdUseCase useCase;

  setUp(() {
    repository = MockClientRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    tokenHelper = MockTokenHelper();
    useCase = GetClientByIdUseCase(
        clientRepository: repository,
        tokenSharedPrefs: tokenSharedPrefs,
        tokenHelper: tokenHelper);
  });

  const tClient = ClientEntity(
      clientId: "1",
      firstName: "Test",
      lastName: "Name",
      mobileNo: "123456",
      city: "Kathmandu",
      email: "test@gmail.com",
      password: "test123",
      profilePicture: "default_profile_img.png",
      role: "client");

  const token = "token";
  const role = "client";
  const tClientId = "1";
  final getClientByIdParams = GetClientByIdParams(clientId: tClientId);

  test("Should get client of [clientId: 1] from repository", () async {
    when(() => tokenSharedPrefs.getToken()).thenAnswer((_) async => const Right(token));
    when(() => tokenHelper.getRoleFromToken()).thenAnswer((_) async => role);
    when(() => repository.getClientById(any(), any()))
        .thenAnswer((_) async => const Right(tClient));

    final result = await useCase(getClientByIdParams);

    expect(result, const Right(tClient));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => tokenHelper.getRoleFromToken()).called(1);
    verify(() => repository.getClientById(tClientId, token)).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
    verifyNoMoreInteractions(tokenHelper);
  });

  test("Should return RoleMismatchFailure when role is not client", () async {
    when(() => tokenSharedPrefs.getToken()).thenAnswer((_) async => const Right(token));
    when(() => tokenHelper.getRoleFromToken()).thenAnswer((_) async => "freelancer");

    final result = await useCase(getClientByIdParams);

    expect(result, const Left(RoleMismatchFailure(message: "Access denied. You have to be a client")));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => tokenHelper.getRoleFromToken()).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
    verifyNoMoreInteractions(tokenHelper);
  });
}
