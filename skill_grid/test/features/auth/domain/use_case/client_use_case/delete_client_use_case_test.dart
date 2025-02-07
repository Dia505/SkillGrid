import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/delete_client_use_case.dart';

import '../mock_token_shared_prefs.dart';
import 'mock_client_repository.dart';

void main() {
  late DeleteClientUseCase useCase;
  late MockClientRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockClientRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = DeleteClientUseCase(
        clientRepository: repository, tokenSharedPrefs: tokenSharedPrefs);
  });

  const tClientId = "1";
  const token = "token";
  final deleteClientParams = DeleteClientParams(clientId: tClientId);

  test('Delete client using id', () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => repository.deleteClient(any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(deleteClientParams);

    expect(result, const Right(null));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.deleteClient(tClientId, token)).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  test('delete client using id and checking whether the id is client1',
      () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => repository.deleteClient(any(), any()))
        .thenAnswer(((invocation) async {
      final clientId = invocation.positionalArguments[0] as String;

      if (clientId == "client1") {
        return const Right(null);
      } else {
        return const Left(ApiFailure(message: "Client not found"));
      }
    }));

    final result = await useCase(DeleteClientParams(clientId: "client1"));

    expect(result, const Right(null));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.deleteClient("client1", token));

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
