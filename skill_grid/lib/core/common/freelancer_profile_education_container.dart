import 'package:flutter/material.dart';

class FreelancerProfileEducationContainer extends StatelessWidget {
  final String degreeTitle;
  final String institutionName;
  final String startDate;
  final String endDate;

  const FreelancerProfileEducationContainer(
      {super.key,
      required this.degreeTitle,
      required this.institutionName,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            degreeTitle,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            institutionName,
            style: const TextStyle(color: Color(0XFF707070), fontSize: 15),
          ),
          Text(
            "$startDate - $endDate",
            style: const TextStyle(color: Color(0XFF707070), fontSize: 15),
          )
        ],
      ),
    );
  }
}
