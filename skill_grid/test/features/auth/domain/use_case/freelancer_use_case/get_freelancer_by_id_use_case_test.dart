import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';

import '../mock_token_shared_prefs.dart';
import 'mock_freelancer_repository.dart';

void main() {
  late MockFreelancerRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late GetFreelancerByIdUseCase useCase;

  setUp(() {
    repository = MockFreelancerRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = GetFreelancerByIdUseCase(
        freelancerRepository: repository, tokenSharedPrefs: tokenSharedPrefs);
  });

  final tFreelancer = FreelancerEntity(
      freelancerId: "1",
      firstName: "Test",
      lastName: "Name",
      dateOfBirth: DateTime(1996, 11, 12), 
      mobileNo: "123456",
      address: "Baneshwor",
      city: "Kathmandu",
      email: "test@gmail.com",
      password: "test123",
      profilePicture: "default_profile_img.png",
      backgroundPicture: "default_bg_img.png",
      role: "freelancer",
      jobCategory: "Technology",
      profession: "Developer",
      skills: "flutter",
      yearsOfExperience: 5,
      bio: "......",
      available: true);

  const token = "token";
  const tFreelancerId = "1";
  final getFreelancerByIdParams = GetFreelancerByIdParams(freelancerId: tFreelancerId);

  test("Should get freelancer of [freelancerId: 1] from repository", () async {
    when(() => tokenSharedPrefs.getToken()).thenAnswer((_) async => const Right(token));
    when(() => repository.getFreelancerById(any(), any()))
        .thenAnswer((_) async => Right(tFreelancer));

    final result = await useCase(getFreelancerByIdParams);

    expect(result, Right(tFreelancer)); 

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.getFreelancerById(tFreelancerId, token)).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
