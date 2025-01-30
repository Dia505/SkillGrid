import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/dashboard_sidebar.dart';
import 'package:skill_grid/core/common/home_ongoing_collab_card.dart';
import 'package:skill_grid/core/common/home_recently_viewed_card.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> serviceCategory = [
    {'icon': Icons.computer, 'label': 'Technology'},
    {'icon': Icons.design_services_outlined, 'label': 'Design'},
    {'icon': Icons.ads_click, 'label': 'Marketing'},
    {'icon': Icons.bar_chart, 'label': 'Business'},
    {'icon': Icons.school, 'label': 'Education'},
    {'icon': Icons.camera_alt_outlined, 'label': 'Photography'},
    {'icon': Icons.palette_outlined, 'label': 'Artisan and Craft'},
    {'icon': Icons.create_outlined, 'label': 'Content Creation'},
  ];

  final List<Map<String, dynamic>> popularServices = [
    {
      'service_img': "assets/images/ux_design_service.png",
      'label': 'UI/UX Design'
    },
    {
      'service_img': "assets/images/digital_marketing_service.jpg",
      'label': 'Digital Marketing'
    },
    {
      'service_img': "assets/images/photography_service.jpg",
      'label': 'Photography'
    },
    {
      'service_img': "assets/images/web_dev_service.jpg",
      'label': 'Web Development'
    },
    {
      'service_img': "assets/images/graphic_design_service.jpg",
      'label': 'Graphic Design'
    },
    {
      'service_img': "assets/images/content_writing_service.jpg",
      'label': 'Content Writing'
    },
    {
      'service_img': "assets/images/app_dev_service.jpg",
      'label': 'App Development'
    },
    {
      'service_img': "assets/images/social_media_marketing_service.jpg",
      'label': 'Social Media Marketing'
    },
    {
      'service_img': "assets/images/video_edit_service.jpg",
      'label': 'Video Editing'
    },
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: const DashboardSidebar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 290,
                    padding: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Color(0xFF2F2A86), Color(0xFF3D007F)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Hello John👋",
                                style: TextStyle(
                                    color: Color(0xFFCCCAFF), fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      "assets/images/client_profile_img.jpg"),
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Discover exceptional talent tailored to your needs.",
                            style: TextStyle(
                                fontFamily: "Caprasimo",
                                fontSize: 20,
                                color: Color(0xFFE7E7FF)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFD3D2FF),
                                      border: InputBorder.none,
                                      hintText: "Search freelancer",
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF858585),
                                          fontFamily: "Inter Medium")),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF7C76E4),
                                      padding: EdgeInsets.zero),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ongoing Collaborations",
                          style: TextStyle(
                              fontSize: 22, fontFamily: "Inter Light"),
                        ),
                        const SizedBox(height: 10),
                        const HomeOngoingCollabCard(
                          freelancerProfileImgPath:
                              "assets/images/istockphoto-1354842602-612x612.jpg",
                          freelancerName: "Anjali Karki",
                          projectName: "Bank Management System",
                          deadlineDuration: "5 days",
                          completePercent: 65,
                          rating: "⭐⭐⭐⭐⭐",
                        ),
                        const SizedBox(height: 10),
                        const HomeOngoingCollabCard(
                          freelancerProfileImgPath:
                              "assets/images/indian_girl_stock_img.jpg",
                          freelancerName: "Rita Singh",
                          projectName: "Bank advertisement videography",
                          deadlineDuration: "2 hours",
                          completePercent: 85,
                          rating: "⭐⭐⭐⭐⭐",
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 0, // Space before the line (left)
                          endIndent: 25, // Space after the line (right)
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Service Category",
                          style: TextStyle(
                              fontSize: 22, fontFamily: "Inter Light"),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                serviceCategory.asMap().entries.map((entry) {
                              var category =
                                  entry.value; // Access the map (category)

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            const Color(0xFF03006F),
                                        child: Icon(
                                          category['icon'],
                                          size: 30,
                                          color: Colors.white,
                                        )), // Access the icon from the map

                                    const SizedBox(height: 8),

                                    Text(category['label'],
                                        style: const TextStyle(
                                            fontSize:
                                                16)), // Access the label from the map
                                  ],
                                ),
                              );
                            }).toList(), // Converts the iterable to a list of widgets
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Top Rated Freelancers",
                          style: TextStyle(
                              fontSize: 22, fontFamily: "Inter Light"),
                        ),
                        const SizedBox(height: 10),
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HomeRecentlyViewedCard(
                                portfolioImgPath:
                                    "assets/images/gettyimages-480952865-612x612.jpg",
                                freelancerProfileImgPath:
                                    "assets/images/istockphoto-1395071229-612x612.jpg",
                                freelancerName: "Krishna Basnet",
                                profession: "Photographer/Videographer",
                                rating: "⭐⭐⭐⭐",
                                hourlyRate: "1500",
                              ),
                              HomeRecentlyViewedCard(
                                portfolioImgPath:
                                    "assets/images/Screenshot 2024-12-01 003357.png",
                                freelancerProfileImgPath:
                                    "assets/images/gettyimages-484274251-612x612.jpg",
                                freelancerName: "Amaira Yadav",
                                profession: "Photographer",
                                rating: "⭐⭐⭐⭐⭐",
                                hourlyRate: "5000",
                              ),
                              HomeRecentlyViewedCard(
                                portfolioImgPath:
                                    "assets/images/food-photographer-ideas.jpg",
                                freelancerProfileImgPath:
                                    "assets/images/indian_girl_stock_img.jpg",
                                freelancerName: "Rita Singh",
                                profession: "Photographer",
                                rating: "⭐⭐⭐⭐⭐",
                                hourlyRate: "3000",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Popular Services",
                          style: TextStyle(
                              fontSize: 22, fontFamily: "Inter Light"),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: popularServices.map((service) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          service["service_img"],
                                          width: 150,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        service["label"],
                                        style: const TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ));
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
