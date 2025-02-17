part of 'freelancer_profile_bloc.dart';

@immutable
sealed class FreelancerProfileEvent extends Equatable {
  const FreelancerProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchFreelancerDetails extends FreelancerProfileEvent {
  final String freelancerId;

  const FetchFreelancerDetails({required this.freelancerId});

  @override
  List<Object> get props => [freelancerId];
}