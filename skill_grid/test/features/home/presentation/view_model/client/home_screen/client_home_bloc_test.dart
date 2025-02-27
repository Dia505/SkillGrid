import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';

import '../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

class MockSearchFreelancerUseCase extends Mock
    implements SearchFreelancersUseCase {}

class MockGetAppointmentByClientIdUseCase extends Mock
    implements GetAppointmentByClientIdUseCase {}

void main() {
  late GetClientByIdUseCase getClientByIdUseCase;
  late MockTokenHelper tokenHelper;
  late SearchFreelancersUseCase searchFreelancersUseCase;
  late GetAppointmentByClientIdUseCase getAppointmentByClientIdUseCase;
  late ClientHomeBloc clientHomeBloc;

  setUp(() {
    getClientByIdUseCase = MockGetClientByIdUseCase();
    tokenHelper = MockTokenHelper();
    searchFreelancersUseCase = MockSearchFreelancerUseCase();
    getAppointmentByClientIdUseCase = MockGetAppointmentByClientIdUseCase();

    clientHomeBloc = ClientHomeBloc(
        getClientByIdUseCase: getClientByIdUseCase,
        tokenHelper: tokenHelper,
        searchFreelancersUseCase: searchFreelancersUseCase,
        getAppointmentByClientIdUseCase: getAppointmentByClientIdUseCase);

    registerFallbackValue(GetClientByIdParams(clientId: "1"));
  });

  group("Client Home Bloc, loadClient", () {
    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

    blocTest<ClientHomeBloc, ClientHomeState>(
      "emits [ClientHomeLoading, ClientHomeLoaded] when components of home are fetched",
      build: () {
        when(() => tokenHelper.getUserIdFromToken())
            .thenAnswer((_) async => "1");
        when(() => getClientByIdUseCase(any()))
            .thenAnswer((_) async => const Right(client));

        return clientHomeBloc;
      },
      act: (bloc) => bloc.loadClient(),
      expect: () => [
        ClientHomeLoading(),
        const ClientHomeLoaded(client),
      ],
    );
  });
}
