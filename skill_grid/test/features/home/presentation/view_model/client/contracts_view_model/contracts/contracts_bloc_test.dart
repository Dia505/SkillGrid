import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

import '../../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetAppointmentByClientIdUseCase extends Mock
    implements GetAppointmentByClientIdUseCase {}

class MockGetPaymentByAppointmentIdUseCase extends Mock
    implements GetPaymentByAppointmentIdUseCase {}

void main() {
  late GetAppointmentByClientIdUseCase getAppointmentByClientIdUseCase;
  late MockTokenHelper tokenHelper;
  late GetPaymentByAppointmentIdUseCase getPaymentByAppointmentIdUseCase;
  late ContractsBloc contractsBloc;

  setUp(() {
    getAppointmentByClientIdUseCase = MockGetAppointmentByClientIdUseCase();
    tokenHelper = MockTokenHelper();
    getPaymentByAppointmentIdUseCase = MockGetPaymentByAppointmentIdUseCase();

    contractsBloc = ContractsBloc(
        getAppointmentByClientIdUseCase: getAppointmentByClientIdUseCase,
        tokenHelper: tokenHelper,
        getPaymentByAppointmentIdUseCase: getPaymentByAppointmentIdUseCase);

    registerFallbackValue(GetAppointmentByClientIdParams(clientId: "1"));
    registerFallbackValue(
        GetPaymentByAppointmentIdParams(appointmentId: "101"));
  });

  group("Contracts Bloc - loadClientContracts", () {
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
    var freelancerService1 = FreelancerServiceEntity(
        freelancerServiceId: "201",
        hourlyRate: 100,
        service: service,
        freelancer: freelancer);
    var appointment1 = AppointmentEntity(
        appointmentId: "103",
        appointmentPurpose: "test purpose",
        appointmentDate: DateTime(2024, 1, 7),
        projectDuration: const ProjectDuration(value: 2, unit: "month"),
        status: true,
        freelancerService: freelancerService1,
        client: client);

    var appointments = [
      AppointmentEntity(
          appointmentId: "103",
          appointmentPurpose: "test purpose",
          appointmentDate: DateTime(2024, 1, 7),
          projectDuration: const ProjectDuration(value: 2, unit: "month"),
          status: true,
          freelancerService: freelancerService1,
          client: client)
    ];

    var billingAddress1 = const BillingAddressEntity(
        billingAddressId: "333", address: "New road", city: "Kathmandu");

    var payment1 = PaymentEntity(
        paymentId: "244",
        paymentMethod: "Cash",
        paymentStatus: true,
        appointment: appointment1,
        billingAddress: billingAddress1);

    var payments = [
      PaymentEntity(
          paymentId: "244",
          paymentMethod: "Cash",
          paymentStatus: true,
          appointment: appointment1,
          billingAddress: billingAddress1)
    ];

    blocTest<ContractsBloc, ContractsState>(
        "emits [ContractsLoadingState, ContractsLoadedState] when contracts are successfully fetched",
        build: () {
          when(() => tokenHelper.getUserIdFromToken())
              .thenAnswer((_) async => "1");
          when(() => getAppointmentByClientIdUseCase(any()))
              .thenAnswer((_) async => Right(appointments));
          when(() => getPaymentByAppointmentIdUseCase(any()))
              .thenAnswer((_) async => Right(payment1));

          return contractsBloc;
        },
        act: (bloc) => bloc.loadClientContracts(),
        expect: () => [
              ContractsLoadingState(),
              ContractsLoadedState(appointments, payments)
            ]);
  });
}
