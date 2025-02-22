import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonContractCard extends StatelessWidget {
  final String freelancerProfileImgPath;
  final String freelancerFirstName;
  final String freelancerLastName;
  final String profession;
  final String appointmentPurpose;
  final String projectEndDate;
  final int amount;
  final String paymentMethod;
  final bool paymentStatus;
  final String appointmentDate;
  final String? appointmentTime;
  final int projectDurationValue;
  final String projectDurationUnit;

  const CommonContractCard(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerFirstName,
      required this.freelancerLastName,
      required this.profession,
      required this.appointmentPurpose,
      required this.projectEndDate,
      required this.amount,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.appointmentDate,
      this.appointmentTime,
      required this.projectDurationUnit,
      required this.projectDurationValue});

  double calculateCompletionPercent() {
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(appointmentDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(projectEndDate);

    int totalDays = endDate.difference(startDate).inDays;

    int elapsedDays = DateTime.now().difference(startDate).inDays;

    double percent = (elapsedDays / totalDays) * 100;

    return percent.clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    double completePercent = calculateCompletionPercent();

    return SizedBox(
      width: 400,
      height: 185,
      child: Card(
        color: const Color(0xFFCCCAFF),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: freelancerProfileImgPath.isNotEmpty
                        ? NetworkImage(
                            "http://10.0.2.2:3000/freelancer_images/$freelancerProfileImgPath") // Adjust base URL
                        : const AssetImage(
                                "assets/images/default_profile_img.png")
                            as ImageProvider,
                    radius: 38,
                  ),
                  Text(
                    "$freelancerFirstName $freelancerLastName",
                    style:
                        const TextStyle(fontFamily: "Inter Bold", fontSize: 15),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      profession,
                      style: const TextStyle(
                          fontSize: 13, fontFamily: "Inter Medium"),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Container(
                width: 2,
                color: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Project details",
                    style: TextStyle(
                        fontFamily: "Caprasimo",
                        fontSize: 17,
                        color: Color(0XFF322E86)),
                  ),
                  SizedBox(
                    width: 235,
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF322E86),
                              fontFamily: "Inter Bold"),
                          children: [
                            const TextSpan(text: "Project: "),
                            TextSpan(
                                text: appointmentPurpose,
                                style: const TextStyle(
                                    fontFamily: "Inter Regular",
                                    color: Colors.black))
                          ]),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                        children: [
                          const TextSpan(text: "Deadline: "),
                          TextSpan(
                              text: projectEndDate,
                              style: const TextStyle(
                                  fontFamily: "Inter Regular",
                                  color: Colors.black))
                        ]),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          width: 180,
                          height: 6,
                          child: LinearProgressIndicator(
                            value: completePercent / 100,
                            backgroundColor: const Color(0xFFC5BDBD),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF236FD2)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("${completePercent.toStringAsFixed(2)}%"),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                        children: [
                          const TextSpan(text: "Amount: "),
                          TextSpan(
                              text: "Rs. $amount",
                              style: const TextStyle(
                                  fontFamily: "Inter Regular",
                                  color: Colors.black))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                        children: [
                          const TextSpan(text: "Payment method: "),
                          TextSpan(
                              text: paymentMethod,
                              style: const TextStyle(
                                  fontFamily: "Inter Regular",
                                  color: Colors.black))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                        children: [
                          const TextSpan(text: "Payment status: "),
                          TextSpan(
                            text: paymentStatus
                                ? "Paid"
                                : "Unpaid", // Conditional text
                            style: TextStyle(
                              fontFamily: "Inter Regular",
                              color: paymentStatus
                                  ? Colors.green
                                  : Colors.red, // Conditional color
                            ),
                          ),
                        ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
