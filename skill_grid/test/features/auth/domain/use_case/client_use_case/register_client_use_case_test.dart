import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/register_client_use_case.dart';
import 'mock_client_repository.mock.dart';

void main() {
  late MockClientRepository repository;
  late RegisterClientUseCase useCase;

  setUp(() {
    repository = MockClientRepository();
    useCase = RegisterClientUseCase(clientRepository: repository);
    registerFallbackValue(ClientEntity.empty());
  });

  const params = CreateClientParams.empty();

  test("Should call [ClientRepository.registerClient]", () async {
    when(() => repository.registerClient(any())).thenAnswer(
      (_) async => Right(null)
    );

    final result = await useCase(params);

    expect(result, Right(null));

    verify(() => repository.registerClient(any())).called(1);

    verifyNoMoreInteractions(repository);
  });
}
