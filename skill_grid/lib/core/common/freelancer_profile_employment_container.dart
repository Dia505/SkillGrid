import 'package:flutter/material.dart';

class FreelancerProfileEmploymentContainer extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String startDate;
  final String endDate;
  final String? description;

  const FreelancerProfileEmploymentContainer(
      {super.key,
      required this.jobTitle,
      required this.companyName,
      required this.startDate,
      required this.endDate,
      this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 338,
      height: 101,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$jobTitle | $companyName",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "$startDate - $endDate",
            style: const TextStyle(color: Color(0XFF707070), fontSize: 15),
          ),
          Text(
            description ?? "",
            style: const TextStyle(color: Color(0XFF707070), fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
