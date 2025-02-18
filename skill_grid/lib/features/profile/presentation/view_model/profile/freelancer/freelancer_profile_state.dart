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
  final List<FreelancerServiceEntity> services;
  final List<PortfolioEntity> portfolios;
  final List<ReviewEntity> reviews;
  final List<EducationEntity> education;

  const FreelancerProfileLoaded(this.freelancerEntity, this.services, this.portfolios, this.reviews, this.education);

  @override
  List<Object?> get props => [freelancerEntity];
}

class FreelancerProfileError extends FreelancerProfileState {
  final String message;
  const FreelancerProfileError(this.message);

  @override
  List<Object?> get props => [message];
}