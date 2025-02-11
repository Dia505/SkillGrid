import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

class PortfolioEntity extends Equatable {
  final String? portfolioId;
  final List<String> filePath;
  final DateTime uploadDate;
  final FreelancerServiceEntity freelancerService;

  const PortfolioEntity({
    this.portfolioId,
    required this.filePath,
    required this.uploadDate,
    required this.freelancerService
  });

  @override
  List<Object?> get props => [portfolioId, filePath, uploadDate, freelancerService];
}