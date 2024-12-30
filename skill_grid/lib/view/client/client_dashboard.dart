import 'package:flutter/material.dart';
import 'package:skill_grid/view/client/dashboard_pages/calendar_screen_view.dart';
import 'package:skill_grid/view/client/dashboard_pages/home_screen_view.dart';
import 'package:skill_grid/view/client/dashboard_pages/notification_screen_view.dart';
import 'package:skill_grid/view/client/dashboard_pages/search screen/search_screen_view.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  int _selectedIndex = 0;

  List<Widget> lstBottomNavScreen = [
    const HomeScreenView(),
    const SearchScreenView(),
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
                    icon: Icon(Icons.search_rounded), label: "Search"),
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
