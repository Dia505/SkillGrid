import 'package:flutter/material.dart';

class FreelancerDashboardStatCard extends StatelessWidget {
  final String cardDashboardEmoji;
  final String cardDashboardValue;
  final String cardDashboardTopic;

  const FreelancerDashboardStatCard(
      {super.key,
      required this.cardDashboardEmoji,
      required this.cardDashboardValue,
      required this.cardDashboardTopic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 170,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                cardDashboardEmoji,
                style: const TextStyle(fontSize: 40),
              ),
              Text(
                cardDashboardValue,
                style:
                    const TextStyle(fontSize: 26, fontFamily: "Inter Medium"),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  cardDashboardTopic,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0XFF707070)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
