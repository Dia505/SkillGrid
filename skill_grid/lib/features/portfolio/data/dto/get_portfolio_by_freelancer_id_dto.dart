import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_api_model.dart';

part 'get_portfolio_by_freelancer_id_dto.g.dart';

@JsonSerializable()
class GetPortfolioByFreelancerIdDto {
  @JsonKey(name: '_id')
  final String? portfolioId;
  @JsonKey(name: 'file_path')
  final List<String> filePath;
  @JsonKey(name: 'upload_date')
  final DateTime uploadDate;
  @JsonKey(name: 'freelancer_service_id')
  final FreelancerServiceApiModel freelancerService;

  GetPortfolioByFreelancerIdDto({
    this.portfolioId,
    required this.filePath,
    required this.uploadDate,
    required this.freelancerService
  });

  factory GetPortfolioByFreelancerIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetPortfolioByFreelancerIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetPortfolioByFreelancerIdDtoToJson(this);
}