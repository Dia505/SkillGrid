import 'package:flutter/material.dart';

class HomeOngoingCollabCard extends StatelessWidget {
  final String freelancerProfileImgPath;
  final String projectName;
  final String deadlineDuration;
  final int completePercent;
  final String freelancerName;
  final String? rating;
  // final VoidCallback onPressed;

  const HomeOngoingCollabCard({
    super.key,
    required this.freelancerProfileImgPath,
    required this.projectName,
    required this.deadlineDuration,
    required this.completePercent,
    required this.freelancerName,
    this.rating,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 120,
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(freelancerProfileImgPath),
                radius: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectName,
                    style: const TextStyle(
                        fontFamily: "Inter Medium",
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  Text(
                    "$deadlineDuration to complete",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          width: 200,
                          height: 6,
                          child: LinearProgressIndicator(
                            value: completePercent /
                                100, // 85% progress (ranges from 0.0 to 1.0)
                            backgroundColor: const Color(
                                0xFFC5BDBD), // Color of the unfilled part
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF236FD2)), // Color of the filled part
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("$completePercent%"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        freelancerName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Text(rating ?? " "),
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
