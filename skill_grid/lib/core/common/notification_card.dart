import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String notificationDate;
  final String freelancerFirstName;
  final String freelancerProfileImgPath;
  final String projectDate;

  const NotificationCard(
      {super.key,
      required this.notificationDate,
      required this.freelancerFirstName,
      required this.freelancerProfileImgPath,
      required this.projectDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 135,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      notificationDate,
                      style: const TextStyle(
                          fontFamily: "Inter Bold", fontSize: 11),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0XFF236FD2),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(freelancerProfileImgPath),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$freelancerFirstName has accepted your offer!",
                        style: const TextStyle(
                            fontSize: 15, fontFamily: "Inter Bold"),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "Your project is set to start on $projectDate. The pricing will be tracked from that date onward. Please review the details in the Contract section.",
                          style: const TextStyle(
                              fontSize: 12, color: Color(0XFF565656)),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
