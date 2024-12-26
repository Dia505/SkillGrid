import 'package:flutter/material.dart';
import 'package:skill_grid/view/freelancer/dashboard_pages/calendar_screen_view.dart';
import 'package:skill_grid/view/freelancer/dashboard_pages/contract_screen_view.dart';
import 'package:skill_grid/view/freelancer/dashboard_pages/home_screen_view.dart';
import 'package:skill_grid/view/freelancer/dashboard_pages/notification_screen_view.dart';

class FreelancerDashboard extends StatefulWidget {
  const FreelancerDashboard({super.key});

  @override
  State<FreelancerDashboard> createState() => _FreelancerDashboardState();
}

class _FreelancerDashboardState extends State<FreelancerDashboard> {
  int _selectedIndex = 0;

  List<Widget> lstBottomNavScreen = [
    const HomeScreenView(),
    const ContractScreenView(),
    const CalendarScreenView(),
    const NotificationScreenView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomNavScreen[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18, left: 20, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_rounded), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.description_outlined), label: "Contract"),
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
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
