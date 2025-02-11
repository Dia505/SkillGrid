import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String notificationDate;
  final String freelancerProfileImgPath;
  final String notificationTitle;
  final String notificationMessage;

  const NotificationCard({
    super.key,
    required this.notificationDate,
    required this.freelancerProfileImgPath,
    required this.notificationTitle,
    required this.notificationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    notificationDate,
                    style: const TextStyle(
                      fontFamily: "Inter Bold",
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Color(0XFF236FD2),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(freelancerProfileImgPath),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationTitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Inter Bold",
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          notificationMessage,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0XFF565656),
                          ),
                          maxLines: 3, // Limits lines if needed
                          overflow: TextOverflow.ellipsis, // Handles overflow
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
