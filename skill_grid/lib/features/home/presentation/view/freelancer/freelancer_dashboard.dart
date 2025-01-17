import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/freelancer/freelancer_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/freelancer/freelancer_dashboard_state.dart';

class FreelancerDashboard extends StatelessWidget {
  const FreelancerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FreelancerDashboardCubit, FreelancerDashboardState>(
          builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
      bottomNavigationBar:
          BlocBuilder<FreelancerDashboardCubit, FreelancerDashboardState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 20, right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard_rounded),
                        label: "Dashboard"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.description_outlined),
                        label: "Contract"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_month_rounded),
                        label: "Calendar"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications), label: "Notification"),
                  ],
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color(0xFF544FBD),
                  unselectedItemColor: Colors.black,
                  iconSize: 30,
                  selectedFontSize: 13,
                  unselectedFontSize: 13,
                  currentIndex: state.selectedIndex,
                  onTap: (index) {
                    context.read<FreelancerDashboardCubit>().onTabTapped(index);
                  }),
            ),
          );
        },
      ),
    );
  }
}
