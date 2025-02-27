import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/review/data/dto/get_review_by_appointment_id_dto.dart';
import 'package:skill_grid/features/review/data/dto/get_review_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/review/data/dto/get_review_by_rating_dto.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';

part 'review_api_model.g.dart';

@JsonSerializable()
class ReviewApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? reviewId;
  final String review;
  final int rating;
  @JsonKey(name: 'review_date')
  final DateTime reviewDate;
  @JsonKey(name: 'client_id')
  final ClientApiModel client;
  @JsonKey(name: 'freelancer_id')
  final FreelancerApiModel freelancer;
  @JsonKey(name: 'appointment_id')
  final AppointmentApiModel appointment;

  const ReviewApiModel(
      {this.reviewId,
      required this.review,
      required this.rating,
      required this.reviewDate,
      required this.client,
      required this.freelancer,
      required this.appointment});

  factory ReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewApiModelToJson(this);

  factory ReviewApiModel.fromEntity(ReviewEntity entity) {
    return ReviewApiModel(
        reviewId: entity.reviewId,
        review: entity.review,
        rating: entity.rating,
        reviewDate: entity.reviewDate,
        client: ClientApiModel.fromEntity(entity.client),
        freelancer: FreelancerApiModel.fromEntity(entity.freelancer),
        appointment: AppointmentApiModel.fromEntity(entity.appointment));
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
        reviewId: reviewId,
        review: review,
        rating: rating,
        reviewDate: reviewDate,
        client: client.toEntity(),
        freelancer: freelancer.toEntity(),
        appointment: appointment.toEntity());
  }

  static List<ReviewEntity> toEntityList(List<ReviewApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static ReviewApiModel fromGetReviewByFreelancerIdDto(
      GetReviewByFreelancerIdDto dto) {
    return ReviewApiModel(
        reviewId: dto.reviewId,
        review: dto.review,
        rating: dto.rating,
        reviewDate: dto.reviewDate,
        client: dto.client,
        freelancer: dto.freelancer,
        appointment: dto.appointment);
  }

  static ReviewApiModel fromGetReviewByRatingDto(GetReviewByRatingDto dto) {
    return ReviewApiModel(
        reviewId: dto.reviewId,
        review: dto.review,
        rating: dto.rating,
        reviewDate: dto.reviewDate,
        client: dto.client,
        freelancer: dto.freelancer,
        appointment: dto.appointment);
  }

  static ReviewEntity getReviewByAppointmentIdDtoToEntity(GetReviewByAppointmentIdDto dto) {
    return ReviewEntity(
      review: dto.review, 
      rating: dto.rating, 
      reviewDate: dto.reviewDate, 
      client: dto.client.toEntity(), 
      freelancer: dto.freelancer.toEntity(), 
      appointment: dto.appointment.toEntity()
    );
  }

  @override
  List<Object?> get props =>
      [reviewId, review, rating, reviewDate, client, freelancer, appointment];
}
