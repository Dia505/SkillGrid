part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {}

class ClientFetched extends ReviewState {
  final ClientEntity client;
  const ClientFetched({required this.client});
}

class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
