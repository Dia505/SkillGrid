import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:skill_grid/features/education/domain/use_case/get_education_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:skill_grid/features/employment/domain/use_case/get_employment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';

part 'freelancer_profile_event.dart';
part 'freelancer_profile_state.dart';

class FreelancerProfileBloc
    extends Bloc<FreelancerProfileEvent, FreelancerProfileState> {
  final GetFreelancerByIdUseCase _getFreelancerByIdUseCase;
  final GetFreelancerServiceByFreelancerIdUseCase
      _getFreelancerServiceByFreelancerIdUseCase;
  final GetPortfolioByFreelancerServiceIdUseCase
      _getPortfolioByFreelancerServiceIdUseCase;
  final GetReviewByFreelancerIdUseCase _getReviewByFreelancerIdUseCase;
  final GetEducationByFreelancerIdUseCase _getEducationByFreelancerIdUseCase;
  final GetEmploymentByFreelancerIdUseCase _getEmploymentByFreelancerIdUseCase;
  final GetAppointmentByFreelancerIdUseCase
      _getAppointmentByFreelancerIdUseCase;

  FreelancerProfileBloc(
      {required GetFreelancerByIdUseCase getFreelancerByIdUseCase,
      required GetFreelancerServiceByFreelancerIdUseCase
          getFreelancerServiceByFreelancerIdUseCase,
      required GetReviewByFreelancerIdUseCase getReviewByFreelancerIdUseCase,
      required GetPortfolioByFreelancerServiceIdUseCase
          getPortfolioByFreelancerServiceIdUseCase,
      required GetEducationByFreelancerIdUseCase
          getEducationByFreelancerIdUseCase,
      required GetEmploymentByFreelancerIdUseCase
          getEmploymentByFreelancerIdUseCase,
      required GetAppointmentByFreelancerIdUseCase
          getAppointmentByFreelancerIdUseCase})
      : _getFreelancerByIdUseCase = getFreelancerByIdUseCase,
        _getFreelancerServiceByFreelancerIdUseCase =
            getFreelancerServiceByFreelancerIdUseCase,
        _getReviewByFreelancerIdUseCase = getReviewByFreelancerIdUseCase,
        _getPortfolioByFreelancerServiceIdUseCase =
            getPortfolioByFreelancerServiceIdUseCase,
        _getEducationByFreelancerIdUseCase = getEducationByFreelancerIdUseCase,
        _getEmploymentByFreelancerIdUseCase =
            getEmploymentByFreelancerIdUseCase,
        _getAppointmentByFreelancerIdUseCase =
            getAppointmentByFreelancerIdUseCase,
        super(FreelancerProfileInitial()) {
    on<FetchFreelancerDetails>(_onFetchFreelancerDetails);
  }

  Future<void> _onFetchFreelancerDetails(FetchFreelancerDetails event,
      Emitter<FreelancerProfileState> emit) async {
    emit(FreelancerProfileLoading());

    final freelancerResult = await _getFreelancerByIdUseCase(
      GetFreelancerByIdParams(freelancerId: event.freelancerId),
    );

    final freelancer = freelancerResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return null;
      },
      (freelancer) => freelancer,
    );

    if (freelancer == null) return;

    // Fetch services
    final servicesResult = await _getFreelancerServiceByFreelancerIdUseCase(
      GetFreelancerServiceByFreelancerIdParams(
          freelancerId: event.freelancerId),
    );

    final services = servicesResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return null;
      },
      (services) => services,
    );

    if (services == null) return;

    final portfoliosResults = await Future.wait(
      services.map((service) async {
        final portfolioResult = await _getPortfolioByFreelancerServiceIdUseCase(
          GetPortfolioByFreelancerServiceIdParams(
              freelancerServiceId: service.freelancerServiceId!),
        );

        return portfolioResult.fold(
          (failure) {
            emit(FreelancerProfileError(failure.message));
            return null; // Return null for failures
          },
          (portfolio) => portfolio, // ✅ portfolio is already a PortfolioEntity
        );
      }),
    );

    final portfolios = portfoliosResults.whereType<PortfolioEntity>().toList();

    // Fetch reviews
    final reviewsResult = await _getReviewByFreelancerIdUseCase(
      GetReviewByFreelancerIdParams(freelancerId: event.freelancerId),
    );

    final reviews = reviewsResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return <ReviewEntity>[];
      },
      (reviews) => reviews,
    );

    // Fetch education details
    final educationResult = await _getEducationByFreelancerIdUseCase(
      GetEducationByFreelancerIdParams(freelancerId: event.freelancerId),
    );

    final education = educationResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return <EducationEntity>[]; // Return an empty list in case of failure
      },
      (education) => education,
    );

    // Fetch employment details
    final employmentResult = await _getEmploymentByFreelancerIdUseCase(
      GetEmploymentByFreelancerIdParams(freelancerId: event.freelancerId),
    );

    final employment = employmentResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return <EmploymentEntity>[];
      },
      (employment) => employment,
    );

    // Fetch appointment details
    final appointmentResult = await _getAppointmentByFreelancerIdUseCase(
      GetAppointmentByFreelancerIdParams(freelancerId: event.freelancerId),
    );

    final appointments = appointmentResult.fold(
      (failure) {
        emit(FreelancerProfileError(failure.message));
        return <AppointmentEntity>[];
      },
      (appointment) => appointment,
    );

    emit(FreelancerProfileLoaded(freelancer, services, portfolios, reviews,
        education, employment, appointments));
  }
}
