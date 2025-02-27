// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_review_by_rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReviewByRatingDto _$GetReviewByRatingDtoFromJson(
        Map<String, dynamic> json) =>
    GetReviewByRatingDto(
      reviewId: json['_id'] as String?,
      review: json['review'] as String,
      rating: (json['rating'] as num).toInt(),
      reviewDate: DateTime.parse(json['review_date'] as String),
      client:
          ClientApiModel.fromJson(json['client_id'] as Map<String, dynamic>),
      freelancer: FreelancerApiModel.fromJson(
          json['freelancer_id'] as Map<String, dynamic>),
      appointment: AppointmentApiModel.fromJson(
          json['appointment_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetReviewByRatingDtoToJson(
        GetReviewByRatingDto instance) =>
    <String, dynamic>{
      '_id': instance.reviewId,
      'review': instance.review,
      'rating': instance.rating,
      'review_date': instance.reviewDate.toIso8601String(),
      'client_id': instance.client,
      'freelancer_id': instance.freelancer,
      'appointment_id': instance.appointment,
    };
