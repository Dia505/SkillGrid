part of 'review_bloc.dart';

@immutable  
sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToContracts extends ReviewEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToContracts({required this.context, required this.destination});
}

class FetchClientData extends ReviewEvent {}

class SaveReview extends ReviewEvent {
  final BuildContext context;
  final String review;
  final int rating;
  final DateTime reviewDate;
  final ClientEntity client;
  final FreelancerEntity freelancer;
  final AppointmentEntity appointment;

  const SaveReview({
    required this.context,
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  });
}