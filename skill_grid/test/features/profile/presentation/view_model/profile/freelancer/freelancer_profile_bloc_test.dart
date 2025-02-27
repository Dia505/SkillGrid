import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/send_an_offer/send_an_offer_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:skill_grid/features/education/domain/use_case/get_education_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:skill_grid/features/employment/domain/use_case/get_employment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart'
    as profile;
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

import '../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetFreelancerByIdUseCase extends Mock
    implements GetFreelancerByIdUseCase {}

class MockGetFreelancerServiceByFreelancerIdUseCase extends Mock
    implements GetFreelancerServiceByFreelancerIdUseCase {}

class MockGetPortfolioByFreelancerServiceIdUseCase extends Mock
    implements GetPortfolioByFreelancerServiceIdUseCase {}

class MockGetReviewByFreelancerIdUseCase extends Mock
    implements GetReviewByFreelancerIdUseCase {}

class MockGetEducationByFreelancerIdUseCase extends Mock
    implements GetEducationByFreelancerIdUseCase {}

class MockGetEmploymentByFreelancerIdUseCase extends Mock
    implements GetEmploymentByFreelancerIdUseCase {}

class MockGetAppointmentByFreelancerIdUseCase extends Mock
    implements GetAppointmentByFreelancerIdUseCase {}

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

void main() {
  late GetFreelancerByIdUseCase getFreelancerByIdUseCase;
  late GetFreelancerServiceByFreelancerIdUseCase
      getFreelancerServiceByFreelancerIdUseCase;
  late GetPortfolioByFreelancerServiceIdUseCase
      getPortfolioByFreelancerServiceIdUseCase;
  late GetReviewByFreelancerIdUseCase getReviewByFreelancerIdUseCase;
  late GetEducationByFreelancerIdUseCase getEducationByFreelancerIdUseCase;
  late GetEmploymentByFreelancerIdUseCase getEmploymentByFreelancerIdUseCase;
  late GetAppointmentByFreelancerIdUseCase getAppointmentByFreelancerIdUseCase;
  late FreelancerProfileBloc freelancerProfileBloc;
  late SendAnOfferBloc sendAnOfferBloc;

  setUp(() {
    getFreelancerByIdUseCase = MockGetFreelancerByIdUseCase();
    getFreelancerServiceByFreelancerIdUseCase =
        MockGetFreelancerServiceByFreelancerIdUseCase();
    getPortfolioByFreelancerServiceIdUseCase =
        MockGetPortfolioByFreelancerServiceIdUseCase();
    getReviewByFreelancerIdUseCase = MockGetReviewByFreelancerIdUseCase();
    getEducationByFreelancerIdUseCase = MockGetEducationByFreelancerIdUseCase();
    getEmploymentByFreelancerIdUseCase =
        MockGetEmploymentByFreelancerIdUseCase();
    getAppointmentByFreelancerIdUseCase =
        MockGetAppointmentByFreelancerIdUseCase();

    sendAnOfferBloc = SendAnOfferBloc(
        getFreelancerByIdUseCase: getFreelancerByIdUseCase,
        getFreelancerServiceByFreelancerIdUseCase:
            getFreelancerServiceByFreelancerIdUseCase,
        tokenHelper: MockTokenHelper(),
        getClientByIdUseCase: MockGetClientByIdUseCase());

    freelancerProfileBloc = FreelancerProfileBloc(
        getFreelancerByIdUseCase: getFreelancerByIdUseCase,
        getFreelancerServiceByFreelancerIdUseCase:
            getFreelancerServiceByFreelancerIdUseCase,
        getReviewByFreelancerIdUseCase: getReviewByFreelancerIdUseCase,
        getPortfolioByFreelancerServiceIdUseCase:
            getPortfolioByFreelancerServiceIdUseCase,
        getEducationByFreelancerIdUseCase: getEducationByFreelancerIdUseCase,
        getEmploymentByFreelancerIdUseCase: getEmploymentByFreelancerIdUseCase,
        getAppointmentByFreelancerIdUseCase:
            getAppointmentByFreelancerIdUseCase,
        sendAnOfferBloc: sendAnOfferBloc);

    registerFallbackValue(GetFreelancerByIdParams(freelancerId: "1"));
    registerFallbackValue(
        GetFreelancerServiceByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(
        GetPortfolioByFreelancerServiceIdParams(freelancerServiceId: "201"));
    registerFallbackValue(GetEducationByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(GetEmploymentByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(GetReviewByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(
        GetAppointmentByFreelancerIdParams(freelancerId: "1"));
  });

  group("Freelancer Profile Bloc, _onFetchFreelancerDetails", () {
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

    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

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
    var portfolio1 = PortfolioEntity(
        portfolioId: "501",
        filePath: const ["image.png", "image2.png"],
        uploadDate: DateTime(2025, 1, 7),
        freelancerService: freelancerService1);

    final freelancerServices = [
      FreelancerServiceEntity(
          freelancerServiceId: "201",
          hourlyRate: 100,
          service: service,
          freelancer: freelancer)
    ];
    final portfolios = [
      PortfolioEntity(
          portfolioId: "501",
          filePath: const ["image.png", "image2.png"],
          uploadDate: DateTime(2025, 1, 7),
          freelancerService: freelancerService1)
    ];
    final appointments = [
      AppointmentEntity(
          appointmentId: "103",
          appointmentPurpose: "test purpose",
          appointmentDate: DateTime(2024, 1, 7),
          projectDuration: const ProjectDuration(value: 2, unit: "month"),
          status: true,
          freelancerService: freelancerService1,
          client: client)
    ];
    final reviews = [
      ReviewEntity(
          reviewId: "301",
          rating: 5,
          review: "Great work!",
          reviewDate: DateTime(2025, 2, 12),
          appointment: appointment1,
          client: client,
          freelancer: freelancer)
    ];
    final educations = [
      EducationEntity(
          educationId: "401",
          degreeTitle: "BSc CSIT",
          institutionName: "Softwarica",
          startDate: DateTime(2017, 9, 12),
          endDate: DateTime(2020, 9, 12),
          freelancer: freelancer)
    ];
    final employments = [
      EmploymentEntity(
          employmentId: "501",
          companyName: "TechCorp",
          jobTitle: "Junior developer",
          startDate: DateTime(2017, 9, 12),
          endDate: DateTime(2020, 9, 12),
          freelancer: freelancer)
    ];
    const freelancerId = "1";

    blocTest<FreelancerProfileBloc, FreelancerProfileState>(
      "emits [FreelancerProfileLoading, FreelancerProfileLoaded] when data is fetched successfully",
      build: () {
        when(() => getFreelancerByIdUseCase(any()))
            .thenAnswer((_) async => Right(freelancer));
        when(() => getFreelancerServiceByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(freelancerServices));
        when(() => getPortfolioByFreelancerServiceIdUseCase(any()))
            .thenAnswer((_) async => Right(portfolio1));
        when(() => getReviewByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(reviews));
        when(() => getEducationByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(educations));
        when(() => getEmploymentByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(employments));
        when(() => getAppointmentByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(appointments));

        return freelancerProfileBloc;
      },
      act: (bloc) =>
          bloc.add(const FetchFreelancerDetails(freelancerId: freelancerId)),
      expect: () => [
        profile.FreelancerProfileLoading(),
        profile.FreelancerProfileLoaded(
          freelancer,
          freelancerServices,
          portfolios,
          reviews,
          educations,
          employments,
          appointments,
        ),
      ],
    );

    blocTest<FreelancerProfileBloc, FreelancerProfileState>(
      "emits [FreelancerProfileLoading, FreelancerProfileError] when fetching freelancer fails",
      build: () {
        when(() => getFreelancerByIdUseCase(any())).thenAnswer((_) async =>
            const Left(ApiFailure(message: "Freelancer not found")));

        return freelancerProfileBloc;
      },
      act: (bloc) =>
          bloc.add(const FetchFreelancerDetails(freelancerId: freelancerId)),
      expect: () => [
        profile.FreelancerProfileLoading(),
        const FreelancerProfileError("Freelancer not found"),
      ],
    );
  });
}
