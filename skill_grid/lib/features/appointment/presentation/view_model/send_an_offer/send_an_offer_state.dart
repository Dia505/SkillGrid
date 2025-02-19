part of 'send_an_offer_bloc.dart';

abstract class SendAnOfferState extends Equatable {
  const SendAnOfferState();

  @override
  List<Object?> get props => [];
}

class SendAnOfferInitial extends SendAnOfferState {}

class FreelancerProfileLoading extends SendAnOfferState {}

class FreelancerProfileLoaded extends SendAnOfferState {
  final FreelancerEntity freelancerEntity;
  final List<FreelancerServiceEntity> services;

  const FreelancerProfileLoaded(this.freelancerEntity, this.services);

  @override
  List<Object?> get props => [freelancerEntity, services];
}

class AppointmentDetailsFilled extends SendAnOfferState {
  final AppointmentEntity appointmentEntity;
  const AppointmentDetailsFilled(this.appointmentEntity);
}

class SendAnOfferError extends SendAnOfferState {
  final String message;
  const SendAnOfferError(this.message);

  @override
  List<Object?> get props => [message];
}
