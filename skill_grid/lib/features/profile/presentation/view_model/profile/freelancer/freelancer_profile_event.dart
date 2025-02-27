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

class NavigateToSendAnOffer extends FreelancerProfileEvent {
  final String freelancerId;
  final BuildContext context;
  final Widget destination;

  const NavigateToSendAnOffer({required this.freelancerId, required this.context, required this.destination});

  @override
  List<Object> get props => [freelancerId];
}