import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/dashboard_pages/calendar_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/dashboard_pages/contract_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/dashboard_pages/home_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/dashboard_pages/notification_screen_view.dart';

class FreelancerDashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const FreelancerDashboardState(
      {required this.selectedIndex, required this.views});

  static FreelancerDashboardState initial() {
    return const FreelancerDashboardState(selectedIndex: 0, views: [
      HomeScreenView(),
      ContractScreenView(),
      CalendarScreenView(),
      NotificationScreenView()
    ]);
  }

  FreelancerDashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return FreelancerDashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
