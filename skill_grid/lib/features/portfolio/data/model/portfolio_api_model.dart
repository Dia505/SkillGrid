import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_api_model.dart';
import 'package:skill_grid/features/portfolio/data/dto/get_portfolio_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/portfolio/data/dto/get_portfolio_by_freelancer_service_id_dto.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';

part 'portfolio_api_model.g.dart';

@JsonSerializable()
class PortfolioApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? portfolioId;
  @JsonKey(name: 'file_path')
  final List<String> filePath;
  @JsonKey(name: 'upload_date')
  final DateTime uploadDate;
  @JsonKey(name: 'freelancer_service_id')
  final FreelancerServiceApiModel freelancerService;

  const PortfolioApiModel({
    this.portfolioId,
    required this.filePath,
    required this.uploadDate,
    required this.freelancerService
  });

  factory PortfolioApiModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioApiModelToJson(this);

  factory PortfolioApiModel.fromEntity(PortfolioEntity entity) {
    return PortfolioApiModel(
      portfolioId: entity.portfolioId,
      filePath: entity.filePath, 
      uploadDate: entity.uploadDate, 
      freelancerService: FreelancerServiceApiModel.fromEntity(entity.freelancerService)
    );
  }

  PortfolioEntity toEntity() {
    return PortfolioEntity(
      portfolioId:  portfolioId,
      filePath: filePath, 
      uploadDate: uploadDate, 
      freelancerService: freelancerService.toEntity()
    );
  }

  static List<PortfolioEntity> toEntityList(
          List<PortfolioApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static PortfolioApiModel fromDto(GetPortfolioByFreelancerIdDto dto) {
    return PortfolioApiModel(
      portfolioId: dto.portfolioId,
      filePath: dto.filePath, 
      uploadDate: dto.uploadDate, 
      freelancerService: dto.freelancerService
    );
  }

  static PortfolioEntity getPortfolioByFreelancerServiceIdDtoToEntity(GetPortfolioByFreelancerServiceIdDto dto) {
    return PortfolioEntity(
      portfolioId: dto.portfolioId,
      filePath: dto.filePath, 
      uploadDate: dto.uploadDate, 
      freelancerService: dto.freelancerService.toEntity()
    );
  }

  @override
  List<Object?> get props => [portfolioId, filePath, uploadDate, freelancerService];
}