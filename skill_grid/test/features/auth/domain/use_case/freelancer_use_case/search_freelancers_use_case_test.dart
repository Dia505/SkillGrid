import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';

import 'mock_freelancer_repository.dart';

void main() {
  late MockFreelancerRepository repository;
  late SearchFreelancersUseCase useCase;

  setUp(() {
    repository = MockFreelancerRepository();
    useCase = SearchFreelancersUseCase(freelancerRepository: repository);
  });

  final freelancers = [
    FreelancerEntity(
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
      available: true),

      FreelancerEntity(
      freelancerId: "2",
      firstName: "John",
      lastName: "Doe",
      dateOfBirth: DateTime(2001, 03, 12), 
      mobileNo: "98765",
      address: "Koteshwor",
      city: "Kathmandu",
      email: "johndoe@gmail.com",
      password: "johndoe123",
      profilePicture: "default_profile_img.png",
      backgroundPicture: "default_bg_img.png",
      role: "freelancer",
      jobCategory: "Design",
      profession: "Graphic designer",
      skills: "adobe photoshop",
      yearsOfExperience: 3,
      bio: "......",
      available: true)
  ];

  const tSearchQuery1 = "Test";
  final searchFreelancersParams1 = SearchFreelancersParams(searchQuery: tSearchQuery1);

  const tSearchQuery2 = "Design";
  final searchFreelancersParams2 = SearchFreelancersParams(searchQuery: tSearchQuery2);

  test("Should return freelancer with [first_name: Test] from repository", () async {
    when(() => repository.searchFreelancers(any()))
        .thenAnswer((_) async => Right(freelancers));

    final result = await useCase(searchFreelancersParams1);

    expect(result, Right(freelancers)); 

    verify(() => repository.searchFreelancers(tSearchQuery1)).called(1);

    verifyNoMoreInteractions(repository);
  });

  test("Should return freelancer with [job_category: Design] from repository", () async {
    when(() => repository.searchFreelancers(any()))
        .thenAnswer((_) async => Right(freelancers));

    final result = await useCase(searchFreelancersParams2);

    expect(result, Right(freelancers)); 

    verify(() => repository.searchFreelancers(tSearchQuery2)).called(1);

    verifyNoMoreInteractions(repository);
  });
}