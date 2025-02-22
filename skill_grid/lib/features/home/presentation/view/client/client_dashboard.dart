import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_state.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientDashboardCubit, ClientDashboardState>(
          builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
      bottomNavigationBar:
          BlocBuilder<ClientDashboardCubit, ClientDashboardState>(
              builder: (context, state) {
        return ClipRRect(
          child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_rounded), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.description_outlined),
                    label: "Contracts"),
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
                context.read<ClientDashboardCubit>().onTabTapped(index);
              }),
        );
      }),
    );
  }
}
