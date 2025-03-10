import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeOngoingCollabCard extends StatelessWidget {
  final String freelancerProfileImgPath;
  final String projectName;
  final String projectEndDate;
  final String appointmentDate;
  final String? appointmentTime;
  final int projectDurationValue;
  final String projectDurationUnit;
  final String freelancerFirstName;
  final String freelancerLastName;

  const HomeOngoingCollabCard({
    super.key,
    required this.freelancerProfileImgPath,
    required this.projectName,
    required this.projectEndDate,
    required this.appointmentDate,
    this.appointmentTime,
    required this.projectDurationUnit,
    required this.projectDurationValue,
    required this.freelancerFirstName,
    required this.freelancerLastName,
  });

  int calculateCompletionPercent() {
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(appointmentDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(projectEndDate);

    int totalDays = endDate.difference(startDate).inDays;

    int elapsedDays = DateTime.now().difference(startDate).inDays;

    double percent = (elapsedDays / totalDays) * 100;

    return percent.clamp(0, 100).round();
  }

  int calculateRemainingDays() {
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(appointmentDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(projectEndDate);

    int totalDays = endDate.difference(startDate).inDays;
    return totalDays;
  }

  @override
  Widget build(BuildContext context) {
    int completePercent = calculateCompletionPercent();
    int remainingDays = calculateRemainingDays();

    return SizedBox(
      width: 350,
      height: 150,
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
                backgroundImage: freelancerProfileImgPath.isNotEmpty
                    ? NetworkImage(
                        "http://10.0.2.2:3000/freelancer_images/$freelancerProfileImgPath") // Adjust base URL
                    : const AssetImage("assets/images/default_profile_img.png")
                        as ImageProvider,
                radius: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      projectName,
                      style: const TextStyle(
                          fontFamily: "Inter Medium",
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                  Text(
                    "$remainingDays days to complete",
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
                            value: completePercent / 100,
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
                  Text(
                    "$freelancerFirstName $freelancerLastName",
                    style: const TextStyle(color: Colors.black),
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
