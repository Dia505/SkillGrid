part of 'freelancer_bloc.dart';

@immutable 
sealed class FreelancerEvent extends Equatable {
  const FreelancerEvent();

  @override
  List<Object> get props => [];
}

class RegisterFreelancer extends FreelancerEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String mobileNo;
  final String address;
  final String city;
  final String email;
  final String password;

  const RegisterFreelancer({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.mobileNo,
    required this.address,
    required this.city,
    required this.email,
    required this.password,
  });
}