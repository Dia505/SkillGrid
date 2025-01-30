import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/calendar_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/home_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/notification_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';

class ClientDashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const ClientDashboardState(
      {required this.selectedIndex, required this.views});

  static ClientDashboardState initial() {
    return ClientDashboardState(selectedIndex: 0, views: [
      BlocProvider(
        create: (context) => ClientSidebarBloc(),
        child: const HomeScreenView()
      ),
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
