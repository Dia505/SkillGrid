import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_hive_model.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:uuid/uuid.dart';

part 'portfolio_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.portfolioTableId)
class PortfolioHiveModel extends Equatable {
  @HiveField(0)
  final String? portfolioId;
  @HiveField(1)
  final List<String> filePath;
  @HiveField(2)
  final DateTime uploadDate;
  @HiveField(3)
  final FreelancerServiceHiveModel freelancerService;

  PortfolioHiveModel({
    String? portfolioId,
    required this.filePath,
    required this.uploadDate,
    required this.freelancerService
  })  : portfolioId = portfolioId ?? const Uuid().v4();

  PortfolioHiveModel.initial()
    : portfolioId = "",
      filePath = [],
      uploadDate = DateTime(1970, 1, 1),
      freelancerService = FreelancerServiceHiveModel.initial();

  factory PortfolioHiveModel.fromEntity(PortfolioEntity entity) {
    return PortfolioHiveModel(
      portfolioId: entity.portfolioId,
      filePath: entity.filePath, 
      uploadDate: entity.uploadDate, 
      freelancerService: FreelancerServiceHiveModel.fromEntity(entity.freelancerService)
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

  @override
  List<Object?> get props => [portfolioId, filePath, uploadDate, freelancerService];
}