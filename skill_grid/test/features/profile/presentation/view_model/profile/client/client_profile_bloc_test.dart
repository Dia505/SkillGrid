import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_profile_picture_usecase.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/edit_profile/client_edit_profile_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';

import '../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

class MockUpdateClientProfilePictureUsecase extends Mock
    implements UpdateClientProfilePictureUsecase {}

class MockUpdateClientUseCase extends Mock implements UpdateClientUseCase {}

void main() {
  late GetClientByIdUseCase getClientByIdUseCase;
  late MockTokenHelper tokenHelper;
  late ClientProfileBloc clientProfileBloc;
  late ClientEditProfileBloc clientEditProfileBloc;

  setUp(() {
    getClientByIdUseCase = MockGetClientByIdUseCase();
    tokenHelper = MockTokenHelper();

    clientEditProfileBloc = ClientEditProfileBloc(
      getClientByIdUseCase: getClientByIdUseCase,
      tokenHelper: tokenHelper,
      updateClientProfilePictureUsecase:
          MockUpdateClientProfilePictureUsecase(),
      updateClientUseCase: MockUpdateClientUseCase(),
    );

    clientProfileBloc = ClientProfileBloc(
      getClientByIdUseCase: getClientByIdUseCase,
      tokenHelper: tokenHelper,
      clientEditProfileBloc: clientEditProfileBloc,
    );

    // Register mock argument matchers
    registerFallbackValue(GetClientByIdParams(clientId: "1"));
  });

  group("ClientProfileBloc - loadClient", () {
    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

    blocTest<ClientProfileBloc, ClientProfileState>(
      "emits [ClientProfileLoading, ClientProfileLoaded] when client is successfully fetched",
      build: () {
        when(() => tokenHelper.getUserIdFromToken())
            .thenAnswer((_) async => "1");
        when(() => getClientByIdUseCase(any()))
            .thenAnswer((_) async => const Right(client));
        return clientProfileBloc;
      },
      act: (bloc) => bloc.loadClient(),
      expect: () => [
        ClientProfileLoading(),
        const ClientProfileLoaded(client),
      ],
    );

    blocTest<ClientProfileBloc, ClientProfileState>(
      "emits [ClientProfileLoading, ClientProfileError] when client ID is null",
      build: () {
        when(() => tokenHelper.getUserIdFromToken())
            .thenAnswer((_) async => null);
        return clientProfileBloc;
      },
      act: (bloc) => bloc.loadClient(),
      expect: () => [
        ClientProfileLoading(),
        const ClientProfileError("Client id not found"),
      ],
    );
  });
}
