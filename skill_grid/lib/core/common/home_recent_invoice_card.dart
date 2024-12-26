import 'package:flutter/material.dart';

class HomeRecentInvoiceCard extends StatelessWidget {
  final String freelancerProfileImgPath;
  final String projectName;
  final int amount;
  final String freelancerName;

  const HomeRecentInvoiceCard({
    super.key,
    required this.freelancerProfileImgPath,
    required this.projectName,
    required this.amount,
    required this.freelancerName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 100,
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(freelancerProfileImgPath),
                radius: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      freelancerName,
                      style: const TextStyle(
                        fontFamily: "Inter Medium",
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      projectName,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFFC9F8D5),
                    ),
                    child: const Center(
                      child: Text(
                        "Paid",
                        style: TextStyle(color: Color(0XFF43B925)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Rs. $amount",
                    style: const TextStyle(
                      fontFamily: "Inter Bold",
                      fontSize: 14,
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
