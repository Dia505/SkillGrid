import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/save_appointment_use_case.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/billing_and_payment/billing_and_payment_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/get_billing_address_by_id_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/save_billing_address_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/payment/domain/use_case/save_payment_use_case.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

class MockSaveAppointmentUseCase extends Mock
    implements SaveAppointmentUseCase {}

class MockSaveBillingAddressUseCase extends Mock
    implements SaveBillingAddressUseCase {}

class MockSavePaymentUseCase extends Mock implements SavePaymentUseCase {}

class MockGetAppointmentByIdUseCase extends Mock
    implements GetAppointmentByIdUseCase {}

class MockGetBillingAddressByIdUseCase extends Mock
    implements GetBillingAddressByIdUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late SaveAppointmentUseCase saveAppointmentUseCase;
  late SaveBillingAddressUseCase saveBillingAddressUseCase;
  late SavePaymentUseCase savePaymentUseCase;
  late GetAppointmentByIdUseCase getAppointmentByIdUseCase;
  late GetBillingAddressByIdUseCase getBillingAddressByIdUseCase;
  late BillingAndPaymentBloc billingAndPaymentBloc;

  setUp(() {
    saveAppointmentUseCase = MockSaveAppointmentUseCase();
    saveBillingAddressUseCase = MockSaveBillingAddressUseCase();
    savePaymentUseCase = MockSavePaymentUseCase();
    getAppointmentByIdUseCase = MockGetAppointmentByIdUseCase();
    getBillingAddressByIdUseCase = MockGetBillingAddressByIdUseCase();

    billingAndPaymentBloc = BillingAndPaymentBloc(
        saveAppointmentUseCase: saveAppointmentUseCase,
        savePaymentUseCase: savePaymentUseCase,
        saveBillingAddressUseCase: saveBillingAddressUseCase,
        getAppointmentByIdUseCase: getAppointmentByIdUseCase,
        getBillingAddressByIdUseCase: getBillingAddressByIdUseCase);

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

    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

    var appointment = AppointmentEntity(
        appointmentId: "103",
        appointmentPurpose: "test purpose",
        appointmentDate: DateTime(2025, 4, 1),
        projectDuration: const ProjectDuration(value: 1, unit: "month"),
        status: false,
        freelancerService: freelancerService,
        client: client);

    var billingAddress = const BillingAddressEntity(
        billingAddressId: "407", address: "Kalopul", city: "Kathmandu");

    registerFallbackValue(SaveAppointmentParams(
        appointmentPurpose: "test purpose",
        appointmentDate: DateTime(2025, 4, 1),
        projectDuration: const ProjectDuration(value: 1, unit: "month"),
        status: false,
        freelancerService: freelancerService,
        client: client));

    registerFallbackValue(
        const SaveBillingAddressParams(address: "Kalopul", city: "Kathmandu"));

    registerFallbackValue(SavePaymentParams(
        amount: 1000,
        paymentMethod: "Cash",
        paymentStatus: false,
        appointment: appointment,
        billingAddress: billingAddress));

    registerFallbackValue(const GetAppointmentByIdParams(appointmentId: "103"));

    registerFallbackValue(GetBillingAddressByIdParams(billingAddressId: "407"));
  });

  group("Billing and Payment Bloc, _onSaveAppointment", () {
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

    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

    var appointment = AppointmentEntity(
        appointmentId: "103",
        appointmentPurpose: "test purpose",
        appointmentDate: DateTime(2025, 4, 1),
        projectDuration: const ProjectDuration(value: 1, unit: "month"),
        status: false,
        freelancerService: freelancerService,
        client: client);

    var billingAddress = const BillingAddressEntity(
        billingAddressId: "407", address: "Kalopul", city: "Kathmandu");

    blocTest<BillingAndPaymentBloc, BillingAndPaymentState>(
      'emits [Loading, Success] when appointment is successfully saved',
      build: () {
        when(() => saveAppointmentUseCase(any()))
            .thenAnswer((_) async => const Right('103'));

        when(() => getAppointmentByIdUseCase(any()))
            .thenAnswer((_) async => Right(appointment));

        return billingAndPaymentBloc;
      },
      act: (bloc) {
        bloc.add(SaveAppointment(
            appointmentParams: SaveAppointmentParams(
                appointmentPurpose: "test purpose",
                appointmentDate: DateTime(2025, 4, 1),
                projectDuration: const ProjectDuration(value: 1, unit: "month"),
                status: false,
                freelancerService: freelancerService,
                client: client),
            context: MockBuildContext()));
      },
      expect: () => [
        const BillingAndPaymentState(
            isLoading: true, appointment: null, errorMessage: null),
        BillingAndPaymentState(
          isLoading: false,
          appointment: appointment,
          errorMessage: null,
        ),
      ],
    );

    blocTest<BillingAndPaymentBloc, BillingAndPaymentState>(
      'emits [Loading, Success] when billing address is successfully saved',
      build: () {
        when(() => saveBillingAddressUseCase(any()))
            .thenAnswer((_) async => const Right('407'));

        when(() => getBillingAddressByIdUseCase(any()))
            .thenAnswer((_) async => Right(billingAddress));

        return billingAndPaymentBloc;
      },
      act: (bloc) {
        bloc.add(SaveBillingAddress(
            billingAddressParams: const SaveBillingAddressParams(
                address: "Kalopul", city: "Kathmandu"),
            context: MockBuildContext()));
      },
      expect: () => [
        const BillingAndPaymentState(
            isLoading: true, billingAddress: null, errorMessage: null),
        BillingAndPaymentState(
          isLoading: false,
          billingAddress: billingAddress,
          errorMessage: null,
        ),
      ],
    );
  });
}
