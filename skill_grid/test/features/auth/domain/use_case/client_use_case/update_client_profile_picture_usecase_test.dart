import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_profile_picture_usecase.dart';

import '../mock_token_helper.dart';
import '../mock_token_shared_prefs.dart';
import 'mock_client_repository.dart';

void main() {
  late MockClientRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late MockTokenHelper tokenHelper;
  late UpdateClientProfilePictureUsecase useCase;

  const tClientId = "1";
  const token = "token";
  const role = "client";
  final file = File('path/to/file'); // Example file for profile picture
  final updateClientProfilePictureParams = UpdateClientProfilePictureParams(
    clientId: tClientId,
    file: file,
  );

  setUpAll(() {
    // Register fallback value for File (since File is a concrete class)
    registerFallbackValue(file);
  });

  setUp(() {
    repository = MockClientRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    tokenHelper = MockTokenHelper();
    useCase = UpdateClientProfilePictureUsecase(
      clientRepository: repository,
      tokenSharedPrefs: tokenSharedPrefs,
      tokenHelper: tokenHelper,
    );
  });

  test('should update profile picture', () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));
    when(() => tokenHelper.getRoleFromToken()).thenAnswer((_) async => role);
    when(() => repository.updateProfilePicture(any(), any(), any()))
        .thenAnswer((_) async => const Right("Profile picture updated"));

    final result = await useCase(updateClientProfilePictureParams);

    expect(result, const Right("Profile picture updated"));
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => tokenHelper.getRoleFromToken()).called(1);
    verify(() => repository.updateProfilePicture(tClientId, file, token))
        .called(1);
  });
}
