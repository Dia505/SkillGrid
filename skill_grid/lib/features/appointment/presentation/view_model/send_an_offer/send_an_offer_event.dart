part of 'send_an_offer_bloc.dart';

@immutable
sealed class SendAnOfferEvent extends Equatable {
  const SendAnOfferEvent();

  @override
  List<Object?> get props => [];
}

class FetchFreelancerDetailsEvent extends SendAnOfferEvent {
  final String freelancerId;

  const FetchFreelancerDetailsEvent({required this.freelancerId});

  @override
  List<Object> get props => [freelancerId];
}

class FillAppointmentDetailsEvent extends SendAnOfferEvent {
  final AppointmentEntity appointmentEntity;
  const FillAppointmentDetailsEvent(this.appointmentEntity);
}

class NavigateToFreelancerProfile extends SendAnOfferEvent {
  final String freelancerId;
  final BuildContext context;
  final Widget destination;

  const NavigateToFreelancerProfile(
      {required this.freelancerId,
      required this.context,
      required this.destination});

  @override
  List<Object> get props => [freelancerId];
}

class NavigateToBillingAndPayment extends SendAnOfferEvent {
  final BuildContext context;
  final FreelancerEntity freelancerEntity;
  final AppointmentEntity appointmentEntity;

  const NavigateToBillingAndPayment(
      {required this.context, required this.freelancerEntity, required this.appointmentEntity});

  @override
  List<Object> get props => [];
}
