import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/notification_card.dart';

class NotificationScreenView extends StatelessWidget {
  const NotificationScreenView({super.key});

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
                  backgroundImage: AssetImage(
                      "assets/images/istockphoto-1395071229-612x612.jpg"),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            NotificationCard(
              notificationDate: "30 Nov, 2024",
              notificationTitle: "You received a new review from Akash!",
              freelancerProfileImgPath:
                  "assets/images/1000_F_463221858_50KkvfxxovUaMNlilCmUxrOnTqSpzAlP.jpg",
              notificationMessage:
                  "You earned a 4-star review from Akash for 'Herald College Graduation'. Click here to view their feedback",
            ),
            SizedBox(
              height: 5,
            ),
            NotificationCard(
              notificationDate: "12 Nov, 2024",
              notificationTitle: "New job offer from Susanna",
              freelancerProfileImgPath:
                  "assets/images/istockphoto-1313502972-612x612.jpg",
              notificationMessage:
                  "You have received a job offer for 'Susanna Birthday Photoshoot'. Click here to review and respond.",
            ),
            SizedBox(
              height: 5,
            ),
            NotificationCard(
              notificationDate: "23 Oct, 2024",
              notificationTitle: "New job offer from Samuel",
              freelancerProfileImgPath:
                  "assets/images/portrait-handsome-indian-man-gray-260nw-2031910466.jpg",
              notificationMessage:
                  "You have received a job offer for 'Coventry University marketing photoshoot'. Click here to review and respond..",
            ),
          ],
        ),
      ),
    ));
  }
}
