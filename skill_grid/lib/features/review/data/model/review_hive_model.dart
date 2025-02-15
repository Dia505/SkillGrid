import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_hive_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_hive_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:uuid/uuid.dart';

part 'review_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.reviewTableId)
class ReviewHiveModel extends Equatable {
  @HiveField(0)
  final String? reviewId;
  @HiveField(1)
  final String review;
  @HiveField(2)
  final int rating;
  @HiveField(3)
  final DateTime reviewDate;
  @HiveField(4)
  final ClientHiveModel client;
  @HiveField(5)
  final FreelancerHiveModel freelancer;
  @HiveField(6)
  final AppointmentHiveModel appointment;

  ReviewHiveModel({
    String? reviewId,
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  })  : reviewId = reviewId ?? const Uuid().v4();

  ReviewHiveModel.initial()
    : reviewId = "",
      review = "",
      rating = 0,
      reviewDate = DateTime(1970, 1, 1),
      client = const ClientHiveModel.initial(),
      freelancer = FreelancerHiveModel.initial(),
      appointment = AppointmentHiveModel.initial();

  factory ReviewHiveModel.fromEntity(ReviewEntity entity) {
    return ReviewHiveModel(
      reviewId: entity.reviewId,
      review: entity.review, 
      rating: entity.rating, 
      reviewDate: entity.reviewDate, 
      client: ClientHiveModel.fromEntity(entity.client), 
      freelancer: FreelancerHiveModel.fromEntity(entity.freelancer), 
      appointment: AppointmentHiveModel.fromEntity(entity.appointment)
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      reviewId: reviewId,
      review: review, 
      rating: rating, 
      reviewDate: reviewDate, 
      client: client.toEntity(), 
      freelancer: freelancer.toEntity(), 
      appointment: appointment.toEntity()
    );
  }

  @override
  List<Object?> get props => [reviewId, review, rating, reviewDate, client, freelancer, appointment];
}