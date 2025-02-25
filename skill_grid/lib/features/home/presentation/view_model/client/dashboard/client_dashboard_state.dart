import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/home_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/notification_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';

class ClientDashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const ClientDashboardState(
      {required this.selectedIndex, required this.views});

  static ClientDashboardState initial() {
    return ClientDashboardState(selectedIndex: 0, views: [
      MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => ClientSidebarBloc(
                getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
                tokenHelper: getIt<TokenHelper>(),
                clientProfileBloc: getIt<ClientProfileBloc>(),
                tokenSharedPrefs: getIt<TokenSharedPrefs>(),
                loginBloc: getIt<LoginBloc>())),
        BlocProvider(
            create: (context) => ClientHomeBloc(
                getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
                tokenHelper: getIt<TokenHelper>(),
                searchFreelancersUseCase: getIt<SearchFreelancersUseCase>(),
                getAppointmentByClientIdUseCase: getIt<GetAppointmentByClientIdUseCase>()))
      ], child: const HomeScreenView()),
      BlocProvider(
          create: (context) => SearchBloc(
              searchFreelancersUseCase: getIt<SearchFreelancersUseCase>(),
              getPortfolioByFreelancerServiceIdUseCase: getIt<GetPortfolioByFreelancerServiceIdUseCase>(),
              getFreelancerSerivceByFreelancerIdUseCase: getIt<GetFreelancerServiceByFreelancerIdUseCase>(),
              getReviewByFreelancerIdUseCase: getIt<GetReviewByFreelancerIdUseCase>(),
              freelancerProfileBloc: getIt<FreelancerProfileBloc>()),
          child: const SearchScreenView()),
      BlocProvider(
          create: (context) => ContractsBloc(
              getAppointmentByClientIdUseCase: getIt<GetAppointmentByClientIdUseCase>(),
              tokenHelper: getIt<TokenHelper>(),
              getPaymentByAppointmentIdUseCase: getIt<GetPaymentByAppointmentIdUseCase>()),
          child: const ClientContractsView()),
      const NotificationScreenView()
    ]);
  }

  ClientDashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return ClientDashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
