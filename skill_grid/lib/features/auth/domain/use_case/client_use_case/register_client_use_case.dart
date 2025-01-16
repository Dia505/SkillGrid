import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class CreateClientParams extends Equatable {
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String city;
  final String email;
  final String password;

  const CreateClientParams({
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.city,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, mobileNo, city, email, password];
}

class RegisterClientUseCase implements UsecaseWithParams<void, CreateClientParams> {
  final IClientRepository clientRepository;
  RegisterClientUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, void>> call(CreateClientParams params) async {
    return await clientRepository.registerClient(
      ClientEntity(
        firstName: params.firstName, 
        lastName: params.lastName, 
        mobileNo: params.mobileNo, 
        city: params.city, 
        email: params.email, 
        password: params.password
      )
    );
  }
}