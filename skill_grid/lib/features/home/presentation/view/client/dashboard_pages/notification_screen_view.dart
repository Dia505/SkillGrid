import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/notification_card.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 24, fontFamily: "Inter SemiBold"),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/client_profile_img.jpg"),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            NotificationCard(
              notificationDate: "1 Dec, 2024",
              notificationTitle: "Anjali has accepted your offer!",
              freelancerProfileImgPath:
                  "assets/images/istockphoto-1354842602-612x612.jpg",
              notificationMessage:
                  "Your project is set to start on 5 December, 2024. The pricing will be tracked from that date onward. Please review the details in the Contract section.",
            ),
            SizedBox(
              height: 5,
            ),
            NotificationCard(
              notificationDate: "27 Nov, 2024",
              notificationTitle: "Rita has accepted your offer!",
              freelancerProfileImgPath:
                  "assets/images/indian_girl_stock_img.jpg",
              notificationMessage:
                  "Your project is set to start on 12 December, 2024. The pricing will be tracked from that date onward. Please review the details in the Contract section.",
            ),
          ],
        ),
      ),
    ));
  }
}
