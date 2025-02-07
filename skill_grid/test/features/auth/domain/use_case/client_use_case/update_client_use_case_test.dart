import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_use_case.dart';

import '../mock_token_helper.dart';
import '../mock_token_shared_prefs.dart';
import 'mock_client_repository.dart';

class FakeClientEntity extends Fake implements ClientEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeClientEntity());  // Register the fake class
  });
  
  late MockClientRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late MockTokenHelper tokenHelper;
  late UpdateClientUseCase useCase;

  setUp(() {
    repository = MockClientRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    tokenHelper = MockTokenHelper();
    useCase = UpdateClientUseCase(
      clientRepository: repository,
      tokenSharedPrefs: tokenSharedPrefs,
      tokenHelper: tokenHelper,
    );
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
  const updateParams = UpdateClientParams(
    clientId: tClientId,
    firstName: "Updated",
  );

  test("Should successfully update client details", () async {
    when(() => tokenSharedPrefs.getToken()).thenAnswer((_) async => const Right(token));
    when(() => tokenHelper.getRoleFromToken()).thenAnswer((_) async => role);

    when(() => repository.getClientById(any(), any()))
        .thenAnswer((_) async => const Right(tClient));

    when(() => repository.updateClient(any(), any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(updateParams);

    expect(result, const Right(null));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => tokenHelper.getRoleFromToken()).called(1);
    verify(() => repository.getClientById(tClientId, token)).called(1);
    verify(() => repository.updateClient(tClientId, any(), token)).called(1);
  });
}
