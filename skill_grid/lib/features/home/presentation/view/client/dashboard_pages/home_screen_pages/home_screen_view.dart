import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/home_ongoing_collab_card.dart';
import 'package:skill_grid/core/common/home_recently_viewed_card.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/dashboard_sidebar.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final _searchController = TextEditingController();
  ClientEntity? _client;
  List<AppointmentEntity>? _contracts;

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
  void initState() {
    super.initState();
    context.read<ClientHomeBloc>().loadClient();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color homeHeaderColorStart = themeState.isDarkMode
            ? const Color(0xFF3D007F)
            : const Color(0xFF2F2A86);

        Color homeHeaderColorEnd = themeState.isDarkMode
            ? const Color(0xFF2F2A86)
            : const Color(0xFF3D007F);
        return BlocListener<ClientSidebarBloc, ClientSidebarState>(
          listener: (context, state) {
            if (state is SidebarOpened) {
              _scaffoldKey.currentState?.openDrawer();
            }
          },
          child: GestureDetector(
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
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [homeHeaderColorStart, homeHeaderColorEnd],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocListener<ClientHomeBloc,
                                        ClientHomeState>(
                                      listener: (context, state) {
                                        if (state is ClientHomeLoaded) {
                                          setState(() {
                                            _client = state
                                                .clientEntity; // Save client when loaded
                                          });
                                        }
                                      },
                                      child: BlocBuilder<ClientHomeBloc,
                                          ClientHomeState>(
                                        builder: (context, state) {
                                          if (_client != null) {
                                            return Text(
                                              "Hello ${_client?.firstName}👋",
                                              style: const TextStyle(
                                                  color: Color(0xFFCCCAFF),
                                                  fontSize: 17),
                                            );
                                          } else {
                                            return const Text(
                                              "Hello user👋",
                                              style: TextStyle(
                                                  color: Color(0xFFCCCAFF),
                                                  fontSize: 17),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ClientSidebarBloc>()
                                            .add(ToggleSidebar());
                                      },
                                      child: BlocBuilder<ClientHomeBloc,
                                          ClientHomeState>(
                                        builder: (context, state) {
                                          final client =
                                              _client; // Local variable ensures null-safety

                                          if (client != null) {
                                            String imageUrl =
                                                client.profilePicture ?? '';

                                            return CircleAvatar(
                                              radius: 30,
                                              backgroundImage: client
                                                          .profilePicture !=
                                                      null
                                                  ? NetworkImage(
                                                      imageUrl.replaceFirst(
                                                          'localhost',
                                                          '10.0.2.2'))
                                                  : const AssetImage(
                                                          "assets/images/default_profile_img.png")
                                                      as ImageProvider,
                                            );
                                          } else {
                                            return const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  "assets/images/default_profile_img.png"),
                                            );
                                          }
                                        },
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            backgroundColor:
                                                const Color(0XFF7C76E4),
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
                              BlocListener<ClientHomeBloc, ClientHomeState>(
                                listener: (context, state) {
                                  if (state is HomeContractsLoadedState) {
                                    setState(() {
                                      _contracts = state.appointments;
                                    });
                                  }
                                },
                                child: BlocBuilder<ClientHomeBloc,
                                    ClientHomeState>(
                                  builder: (context, state) {
                                    if (_contracts == null) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (_contracts!.isEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, right: 27),
                                        child: Center(
                                            child: Column(children: [
                                          Image.asset(
                                            "assets/images/client_dashboard_no_collaborations.png",
                                            height: 240,
                                          ),
                                          const SizedBox(
                                            width: 270,
                                            child: Text(
                                              "You haven't started any collaborations yet. Start working with top freelancers and bring your ideas to life!",
                                              style: TextStyle(
                                                  fontFamily: "Inter Medium"),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ])),
                                      );
                                    }

                                    return Container(
                                      height: 200,
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount: _contracts?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final contract = _contracts?[index];
                                          if (contract == null) {
                                            return const SizedBox.shrink();
                                          }
                                          final collabCard =
                                              HomeOngoingCollabCard(
                                            freelancerProfileImgPath: contract
                                                .freelancerService
                                                .freelancer
                                                .profilePicture!,
                                            freelancerFirstName: contract
                                                .freelancerService
                                                .freelancer
                                                .firstName,
                                            freelancerLastName: contract
                                                .freelancerService
                                                .freelancer
                                                .lastName,
                                            projectName:
                                                contract.appointmentPurpose,
                                            appointmentDate:
                                                DateFormat("dd-MM-yyyy").format(
                                                    contract.appointmentDate),
                                            projectEndDate:
                                                DateFormat("dd-MM-yyyy").format(
                                                    contract.projectEndDate!),
                                            appointmentTime:
                                                contract.appointmentTime,
                                            projectDurationUnit:
                                                contract.projectDuration.unit,
                                            projectDurationValue:
                                                contract.projectDuration.value,
                                          );
                                          if (collabCard
                                                  .calculateCompletionPercent() <
                                              100) {
                                            return collabCard;
                                          } else {
                                            return const SizedBox
                                                .shrink(); // Hide completed projects
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
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
                                  children: serviceCategory
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    var category = entry
                                        .value; // Access the map (category)

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                              style:
                                                  const TextStyle(fontSize: 15),
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
          ),
        );
      },
    );
  }
}
