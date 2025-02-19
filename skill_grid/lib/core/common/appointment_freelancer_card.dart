import 'package:flutter/material.dart';

class AppointmentFreelancerCard extends StatelessWidget {
  final String freelancerProfileImgPath;
  final String freelancerName;
  final String profession;
  final String address;
  final String city;
  final String mobileNo;

  const AppointmentFreelancerCard(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerName,
      required this.profession,
      required this.address,
      required this.city,
      required this.mobileNo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 160,
      child: Card(
        color: const Color(0XFF8984F2),
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: CircleAvatar(
                  backgroundImage: freelancerProfileImgPath.isNotEmpty
                      ? NetworkImage(freelancerProfileImgPath.replaceFirst(
                          'localhost', '10.0.2.2'))
                      : const AssetImage(
                              "assets/images/default_profile_img.png")
                          as ImageProvider,
                  radius: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      freelancerName,
                      style: const TextStyle(
                          fontFamily: "Inter Bold",
                          fontSize: 19,
                          color: Colors.white),
                    ),
                    Text(
                      profession,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "$address, $city",
                      style: const TextStyle(
                          color: Color(0XFF450098), fontSize: 13),
                    ),
                    Text(
                      mobileNo,
                      style: const TextStyle(
                          color: Color(0XFF450098), fontSize: 13),
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
