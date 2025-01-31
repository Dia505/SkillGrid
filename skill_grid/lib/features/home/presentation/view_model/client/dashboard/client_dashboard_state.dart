import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/calendar_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/home_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/notification_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';

class ClientDashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const ClientDashboardState(
      {required this.selectedIndex, required this.views});

  static ClientDashboardState initial() {
    return ClientDashboardState(selectedIndex: 0, views: [
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => ClientSidebarBloc()),
        BlocProvider(
            create: (context) => ClientHomeCubit(
                getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
                tokenHelper: getIt<TokenHelper>()))
      ], child: const HomeScreenView()),
      const SearchScreenView(),
      const CalendarScreenView(),
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
