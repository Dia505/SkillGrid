import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/freelancer_profile_review_container.dart';
import 'package:skill_grid/core/common/freelancer_profile_service_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FreelancerProfileView extends StatefulWidget {
  const FreelancerProfileView({super.key});

  @override
  _FreelancerProfileViewState createState() => _FreelancerProfileViewState();
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> serviceCategory = [
    {
      "title": "Website design",
      "rate": 4500,
      "images": [
        "assets/images/b5ccf2b2-3e9a-490b-ac55-a94a768f767a-cover.png",
        "assets/images/best-web-design-3.webp",
        "assets/images/original-9fdc82cb2eeb827abf10f933e53d11ff.jpg",
      ],
    },
    {
      "title": "Mobile app design",
      "rate": 6000,
      "images": [
        "assets/images/0b71f547f247696096e861b71e57b7ea.jpg",
        "assets/images/bf14f681b97237c4b6d48c795b2d525c75ab9dae-1440x835.png",
        "assets/images/image_processing20210430-26016-12xyd9w.jpg",
      ],
    },
    {
      "title": "Graphic design",
      "rate": 3500,
      "images": [
        "assets/images/10472-original.jpg",
        "assets/images/attachment_59153347.png"
      ],
    },
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String fullText =
        "Hi! I'm a versatile designer with a passion for combining user experience (UX) and graphic design to create beautiful, functional, and intuitive digital experiences. With 6 years of experience in both fields, I help businesses design products that not only look great but are also easy to use and meet users' needs.";
    String truncatedText =
        fullText.length > 200 ? '${fullText.substring(0, 200)}...' : fullText;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
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
                          style:
                              TextStyle(color: Color(0XFF707070), fontSize: 15),
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
                          style:
                              TextStyle(color: Color(0XFF707070), fontSize: 15),
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
                              style: TextStyle(
                                  fontSize: 24, fontFamily: "Inter SemiBold"),
                            ),
                            Text(
                              "bookings",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0XFF707070)),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              "6 years",
                              style: TextStyle(
                                  fontSize: 22, fontFamily: "Inter SemiBold"),
                            ),
                            Text(
                              "experience",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0XFF707070)),
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

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Services",
                      style: TextStyle(fontFamily: "Inter Bold", fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: serviceCategory.length,
                        itemBuilder: (context, index) {
                          final service = serviceCategory[index];
                          return FreelancerProfileServiceContainer(
                            title: service['title'],
                            rate: service['rate'],
                            images: service['images'],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: serviceCategory.length,
                        effect: const WormEffect(
                          activeDotColor: Color(0xFF544FBD),
                          dotColor: Color(0xFF707070),
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                      ),
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reviews",
                      style: TextStyle(fontFamily: "Inter Bold", fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    FreelancerProfileReviewContainer(
                      projectTitle: "Figma designs for our management system",
                      rating: "⭐⭐⭐⭐ 4.0",
                      reviewDate: "20 Jan, 2022",
                      review: "“It was great to work with Anjali!”",
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 5),
                    FreelancerProfileReviewContainer(
                      projectTitle:
                          "Create web mockups for Somerset Interior Studio",
                      rating: "⭐⭐⭐⭐⭐ 5.0",
                      reviewDate: "26 May, 2022",
                      review:
                          "“Anjali does amazing work! Delivered a great product”",
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 5),
                    FreelancerProfileReviewContainer(
                      projectTitle: "Meal Rush” mobile app design",
                      rating: "⭐⭐⭐⭐ 4.0",
                      reviewDate: "5 Mar, 2023",
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 5),
                    FreelancerProfileReviewContainer(
                      projectTitle: "Poster for “Study in Europe” seminar",
                      rating: "⭐⭐⭐⭐ 4.0",
                      reviewDate: "6 June, 2023",
                      review: "“It was great to work with Anjali!”",
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
