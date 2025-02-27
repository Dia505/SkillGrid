import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';

part 'get_review_by_freelancer_id_dto.g.dart';

@JsonSerializable()
class GetReviewByFreelancerIdDto {
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

  GetReviewByFreelancerIdDto({
    this.reviewId,
    required this.review,
    required this.rating,
    required this.reviewDate,
    required this.client,
    required this.freelancer,
    required this.appointment
  });

  factory GetReviewByFreelancerIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetReviewByFreelancerIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetReviewByFreelancerIdDtoToJson(this);
}