part of 'freelancer_profile_bloc.dart';

abstract class FreelancerProfileState extends Equatable {
  const FreelancerProfileState();

  @override
  List<Object?> get props => [];
}

class FreelancerProfileInitial extends FreelancerProfileState {}

class FreelancerProfileLoading extends FreelancerProfileState {}

class FreelancerProfileLoaded extends FreelancerProfileState {
  final FreelancerEntity freelancerEntity;
  const FreelancerProfileLoaded(this.freelancerEntity);

  @override
  List<Object?> get props => [freelancerEntity];
}

class FreelancerProfileError extends FreelancerProfileState {
  final String message;
  const FreelancerProfileError(this.message);

  @override
  List<Object?> get props => [message];
}