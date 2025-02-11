import 'package:flutter/material.dart';

class AppointmentFreelancerCard extends StatelessWidget {
  const AppointmentFreelancerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 380,
      height: 160,
      child: Card(
        color: Color(0XFF8984F2),
        child: Padding(
          padding: EdgeInsets.only(left: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                        "assets/images/istockphoto-1354842602-612x612.jpg"),
                  ),
                  Positioned(
                    left: 68,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xFF71D358),
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Anjali Karki",
                      style: TextStyle(
                          fontFamily: "Inter Bold",
                          fontSize: 19,
                          color: Colors.white),
                    ),
                    Text(
                      "UI/Ux Designer, Graphic Designer",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "Kalimati, Kathmandu",
                      style: TextStyle(color: Color(0XFF450098), fontSize: 13),
                    ),
                    Text(
                      "9841223790",
                      style: TextStyle(color: Color(0XFF450098), fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
