import 'package:flutter/material.dart';

class HomeRecentlyViewedCard extends StatelessWidget {
  final String portfolioImgPath;
  final String freelancerProfileImgPath;
  final String freelancerName;
  final String profession;
  final String rating;
  final String hourlyRate;
  // final VoidCallback onPressed;

  const HomeRecentlyViewedCard({
    super.key,
    required this.portfolioImgPath,
    required this.freelancerProfileImgPath,
    required this.freelancerName,
    required this.profession,
    required this.rating,
    required this.hourlyRate,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 200,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.asset(
                portfolioImgPath,
                width: double.infinity,
                height: 87,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage(freelancerProfileImgPath)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      freelancerName,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(profession,
                        style: const TextStyle(
                            color: Color(0xFF707070), fontSize: 11)),
                    Text(rating, style: const TextStyle(fontSize: 11)),
                    Text("From Rs.$hourlyRate/hr",
                        style: const TextStyle(fontSize: 11)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF544FBD),
                          padding: EdgeInsets.zero),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
