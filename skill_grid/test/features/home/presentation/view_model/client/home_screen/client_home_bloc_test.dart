import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

import '../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

class MockGetAppointmentByClientIdUseCase extends Mock
    implements GetAppointmentByClientIdUseCase {}

void main() {
  late GetClientByIdUseCase getClientByIdUseCase;
  late MockTokenHelper tokenHelper;
  late GetAppointmentByClientIdUseCase getAppointmentByClientIdUseCase;
  late ClientHomeBloc clientHomeBloc;

  setUp(() {
    getClientByIdUseCase = MockGetClientByIdUseCase();
    tokenHelper = MockTokenHelper();
    getAppointmentByClientIdUseCase = MockGetAppointmentByClientIdUseCase();

    clientHomeBloc = ClientHomeBloc(
        getClientByIdUseCase: getClientByIdUseCase,
        tokenHelper: tokenHelper,
        getAppointmentByClientIdUseCase: getAppointmentByClientIdUseCase);

    registerFallbackValue(GetClientByIdParams(clientId: "1"));
    registerFallbackValue(GetAppointmentByClientIdParams(clientId: "1"));
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
    var freelancer = FreelancerEntity(
        freelancerId: "1",
        firstName: "Test",
        lastName: "Name",
        dateOfBirth: DateTime(1999, 12, 12),
        mobileNo: "9801223987",
        address: "Kalopul",
        city: "Kathmandu",
        email: "testname@gmail.com",
        password: "Testname@123",
        jobCategory: "Technology",
        profession: "Mobile developer",
        yearsOfExperience: 8,
        skills: "testing",
        bio: "Hello");
    const service =
        ServiceEntity(serviceId: "101", serviceName: "mobile app development");
    var freelancerService = FreelancerServiceEntity(
        freelancerServiceId: "201",
        hourlyRate: 100,
        service: service,
        freelancer: freelancer);
    var appointments = [
      AppointmentEntity(
          appointmentId: "103",
          appointmentPurpose: "test purpose",
          appointmentDate: DateTime(2024, 1, 7),
          projectDuration: const ProjectDuration(value: 2, unit: "month"),
          status: true,
          freelancerService: freelancerService,
          client: client)
    ];

    blocTest<ClientHomeBloc, ClientHomeState>(
      "emits [ClientHomeLoading, ClientHomeLoaded] when components of home are fetched",
      build: () {
        when(() => tokenHelper.getUserIdFromToken())
            .thenAnswer((_) async => "1");
        when(() => getClientByIdUseCase(any()))
            .thenAnswer((_) async => const Right(client));
        when(() => getAppointmentByClientIdUseCase(any()))
            .thenAnswer((_) async => Right(appointments));

        return clientHomeBloc;
      },
      act: (bloc) => bloc.loadClient(),
      expect: () => [
        ClientHomeLoading(),
        const ClientHomeLoaded(client),
        HomeContractsLoadedState(appointments)
      ],
    );
  });
}
