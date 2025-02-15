import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class ReviewEntity extends Equatable {
  final String? reviewId;
  final String review;
  final int rating;
  final DateTime reviewDate;
  final ClientEntity client;
  final FreelancerEntity freelancer;
  final AppointmentEntity appointment;

  const ReviewEntity({
    this.reviewId,
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  });

  @override
  List<Object?> get props => [reviewId, review, rating, reviewDate, client, freelancer, appointment];
}