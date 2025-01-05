import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';

class FreelancerProfileView extends StatefulWidget {
  const FreelancerProfileView({super.key});

  @override
  _FreelancerProfileViewState createState() => _FreelancerProfileViewState();
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String fullText =
        "Hi! I'm a versatile designer with a passion for combining user experience (UX) and graphic design to create beautiful, functional, and intuitive digital experiences. With 6 years of experience in both fields, I help businesses design products that not only look great but are also easy to use and meet users' needs.";
    String truncatedText =
        fullText.length > 200 ? '${fullText.substring(0, 200)}...' : fullText;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Image.asset(
                    "assets/images/swirls-8302543_640.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  bottom: -80,
                  left: 145,
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/istockphoto-1354842602-612x612.jpg"),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  left: 235,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xFF71D358),
                    child: Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              const Text(
                "Anjali Karki",
                style: TextStyle(fontFamily: "Inter Bold", fontSize: 22),
              ),
              const Text(
                "UI/UX Designer, Graphic Designer",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Color(0XFF707070),
                      size: 20,
                    ),
                    Text(
                      "9841223790",
                      style: TextStyle(color: Color(0XFF707070), fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0XFF707070),
                      size: 20,
                    ),
                    Text(
                      "Kupondole, Lalitpur",
                      style: TextStyle(color: Color(0XFF707070), fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  buttonText: "Book an Appointment",
                  buttonColor: const Color(0xFF7975D8),
                  onPressed: () {}),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            width: 305,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      size: 45,
                    ),
                    Column(
                      children: [
                        Text(
                          "120",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "bookings",
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF707070)),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 45,
                    ),
                    Column(
                      children: [
                        Text(
                          "6 years",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "experience",
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF707070)),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          // Read more functionality added here
          Container(
            width: 340,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isExpanded ? fullText : truncatedText,
                  style: const TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? 'Show Less' : 'Read More',
                    style: const TextStyle(
                      color: Color(0XFF544FBD),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
