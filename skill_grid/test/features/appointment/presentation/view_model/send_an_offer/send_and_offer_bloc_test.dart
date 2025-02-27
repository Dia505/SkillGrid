import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/send_an_offer/send_an_offer_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

import '../../../../auth/domain/use_case/mock_token_helper.mock.dart';

class MockGetFreelancerByIdUseCase extends Mock
    implements GetFreelancerByIdUseCase {}

class MockGetFreelancerServiceByFreelancerIdUseCase extends Mock
    implements GetFreelancerServiceByFreelancerIdUseCase {}

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

void main() {
  late GetFreelancerByIdUseCase getFreelancerByIdUseCase;
  late GetFreelancerServiceByFreelancerIdUseCase
      getFreelancerServiceByFreelancerIdUseCase;
  late MockTokenHelper tokenHelper;
  late GetClientByIdUseCase getClientByIdUseCase;
  late SendAnOfferBloc sendAnOfferBloc;

  setUp(() {
    getFreelancerByIdUseCase = MockGetFreelancerByIdUseCase();
    getFreelancerServiceByFreelancerIdUseCase =
        MockGetFreelancerServiceByFreelancerIdUseCase();
    tokenHelper = MockTokenHelper();
    getClientByIdUseCase = MockGetClientByIdUseCase();

    sendAnOfferBloc = SendAnOfferBloc(
        getFreelancerByIdUseCase: getFreelancerByIdUseCase,
        getFreelancerServiceByFreelancerIdUseCase:
            getFreelancerServiceByFreelancerIdUseCase,
        tokenHelper: tokenHelper,
        getClientByIdUseCase: getClientByIdUseCase);

    registerFallbackValue(GetFreelancerByIdParams(freelancerId: "1"));
    registerFallbackValue(
        GetFreelancerServiceByFreelancerIdParams(freelancerId: "1"));
    registerFallbackValue(GetClientByIdParams(clientId: "101"));
  });

  group("Send An Offer Bloc, _onFetchFreelancerDetails", () {
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

    const service =
        ServiceEntity(serviceId: "301", serviceName: "mobile app development");
    var freelancerServices = [
      FreelancerServiceEntity(
          freelancerServiceId: "201",
          hourlyRate: 100,
          service: service,
          freelancer: freelancer1)
    ];
    const client = ClientEntity(
      clientId: "101",
      firstName: "John",
      lastName: "Doe",
      mobileNo: "9818223344",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "Johndoe@123",
    );

    const freelancerId = "1";

    blocTest(
      "emits [FreelancerProfileLoading, FreelancerProfileLoaded] when data is fetched successfully",
      build: () {
        when(() => tokenHelper.getUserIdFromToken())
            .thenAnswer((_) async => "101");
        when(() => getFreelancerByIdUseCase(any()))
            .thenAnswer((_) async => Right(freelancer1));
        when(() => getClientByIdUseCase(any()))
            .thenAnswer((_) async => const Right(client));
        when(() => getFreelancerServiceByFreelancerIdUseCase(any()))
            .thenAnswer((_) async => Right(freelancerServices));

        return sendAnOfferBloc;
      },
      act: (bloc) => bloc
          .add(const FetchFreelancerDetailsEvent(freelancerId: freelancerId)),
      expect: () => [
        FreelancerProfileLoading(),
        FreelancerProfileLoaded(freelancer1, freelancerServices, client)
      ],
    );
  });
}
