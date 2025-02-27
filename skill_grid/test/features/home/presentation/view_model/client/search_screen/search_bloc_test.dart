import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/send_an_offer/send_an_offer_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/education/domain/use_case/get_education_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/employment/domain/use_case/get_employment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

import '../../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockSearchFreelancersUseCase extends Mock
    implements SearchFreelancersUseCase {}

class MockGetPortfolioByFreelancerServiceIdUseCase extends Mock
    implements GetPortfolioByFreelancerServiceIdUseCase {}

class MockGetFreelancerServiceByFreelancerIdUseCase extends Mock
    implements GetFreelancerServiceByFreelancerIdUseCase {}

class MockGetReviewByFreelancerIdUseCase extends Mock
    implements GetReviewByFreelancerIdUseCase {}

class MockGetFreelancerByIdUseCase extends Mock
    implements GetFreelancerByIdUseCase {}

class MockGetEducationByFreelancerIdUseCase extends Mock
    implements GetEducationByFreelancerIdUseCase {}

class MockGetEmploymentByFreelancerIdUseCase extends Mock
    implements GetEmploymentByFreelancerIdUseCase {}

class MockGetAppointmentByFreelancerIdUseCase extends Mock
    implements GetAppointmentByFreelancerIdUseCase {}

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

void main() {
  late SearchFreelancersUseCase searchFreelancersUseCase;
  late GetPortfolioByFreelancerServiceIdUseCase
      getPortfolioByFreelancerServiceIdUseCase;
  late GetFreelancerServiceByFreelancerIdUseCase
      getFreelancerServiceByFreelancerIdUseCase;
  late GetReviewByFreelancerIdUseCase getReviewByFreelancerIdUseCase;
  late FreelancerProfileBloc freelancerProfileBloc;
  late SearchBloc searchBloc;

  setUp(() {
    searchFreelancersUseCase = MockSearchFreelancersUseCase();
    getPortfolioByFreelancerServiceIdUseCase =
        MockGetPortfolioByFreelancerServiceIdUseCase();
    getFreelancerServiceByFreelancerIdUseCase =
        MockGetFreelancerServiceByFreelancerIdUseCase();
    getReviewByFreelancerIdUseCase = MockGetReviewByFreelancerIdUseCase();
    getReviewByFreelancerIdUseCase = MockGetReviewByFreelancerIdUseCase();

    freelancerProfileBloc = FreelancerProfileBloc(
        getFreelancerByIdUseCase: MockGetFreelancerByIdUseCase(),
        getFreelancerServiceByFreelancerIdUseCase:
            MockGetFreelancerServiceByFreelancerIdUseCase(),
        getReviewByFreelancerIdUseCase: getReviewByFreelancerIdUseCase,
        getPortfolioByFreelancerServiceIdUseCase:
            getPortfolioByFreelancerServiceIdUseCase,
        getEducationByFreelancerIdUseCase:
            MockGetEducationByFreelancerIdUseCase(),
        getEmploymentByFreelancerIdUseCase:
            MockGetEmploymentByFreelancerIdUseCase(),
        getAppointmentByFreelancerIdUseCase:
            MockGetAppointmentByFreelancerIdUseCase(),
        sendAnOfferBloc: SendAnOfferBloc(
            getFreelancerByIdUseCase: MockGetFreelancerByIdUseCase(),
            getFreelancerServiceByFreelancerIdUseCase:
                getFreelancerServiceByFreelancerIdUseCase,
            tokenHelper: MockTokenHelper(),
            getClientByIdUseCase: MockGetClientByIdUseCase()));

    searchBloc = SearchBloc(
        searchFreelancersUseCase: searchFreelancersUseCase,
        getPortfolioByFreelancerServiceIdUseCase:
            getPortfolioByFreelancerServiceIdUseCase,
        getFreelancerSerivceByFreelancerIdUseCase:
            getFreelancerServiceByFreelancerIdUseCase,
        getReviewByFreelancerIdUseCase: getReviewByFreelancerIdUseCase,
        freelancerProfileBloc: freelancerProfileBloc);

    registerFallbackValue(SearchFreelancersParams(searchQuery: "Test"));
    registerFallbackValue(
        GetFreelancerServiceByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(
        GetPortfolioByFreelancerServiceIdParams(freelancerServiceId: "201"));
    registerFallbackValue(GetReviewByFreelancerIdParams(freelancerId: "1"));
  });

  group("Search Bloc, _onSearchFreelancers", () {
    const searchQuery = "Test";

    var freelancer1 = FreelancerEntity(
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

    final freelancers = [
      FreelancerEntity(
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
          bio: "Hello")
    ];

    const service =
        ServiceEntity(serviceId: "101", serviceName: "mobile app development");
    var freelancerService1 = FreelancerServiceEntity(
        freelancerServiceId: "201",
        hourlyRate: 100,
        service: service,
        freelancer: freelancer1);
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
          freelancer: freelancer1)
    ];

    const client = ClientEntity(
      clientId: "1",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );
    var appointment1 = AppointmentEntity(
        appointmentId: "103",
        appointmentPurpose: "test purpose",
        appointmentDate: DateTime(2024, 1, 7),
        projectDuration: const ProjectDuration(value: 2, unit: "month"),
        status: true,
        freelancerService: freelancerService1,
        client: client);
    final reviews = [
      ReviewEntity(
          reviewId: "301",
          rating: 5,
          review: "Great work!",
          reviewDate: DateTime(2025, 2, 12),
          appointment: appointment1,
          client: client,
          freelancer: freelancer1)
    ];

    final portfolioMap = {
      freelancer1.freelancerId!: ["image.png", "image2.png"]
    };
    final avgHourlyRateMap = {freelancer1.freelancerId!: 100};
    final avgRatingMap = {freelancer1.freelancerId!: 5};

    blocTest<SearchBloc, SearchState>(
        "emits [SearchLoading, SearchLoaded] when data is fetched successfully",
        build: () {
          when(() => searchFreelancersUseCase(any()))
              .thenAnswer((_) async => Right(freelancers));
          when(() => getFreelancerServiceByFreelancerIdUseCase(any()))
              .thenAnswer((_) async => Right(freelancerServices));
          when(() => getPortfolioByFreelancerServiceIdUseCase(any()))
              .thenAnswer((_) async => Right(portfolio1));
          when(() => getReviewByFreelancerIdUseCase(any()))
              .thenAnswer((_) async => Right(reviews));

          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchFreelancers(searchQuery)),
        expect: () => [
              SearchLoading(),
              SearchLoaded(
                  freelancers, portfolioMap, avgHourlyRateMap, avgRatingMap)
            ]);
  });

}
