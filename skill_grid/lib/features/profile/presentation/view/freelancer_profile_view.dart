import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/freelancer_profile_education_container.dart';
import 'package:skill_grid/core/common/freelancer_profile_employment_container.dart';
import 'package:skill_grid/core/common/freelancer_profile_review_container.dart';
import 'package:skill_grid/core/common/freelancer_profile_service_container.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/presentation/view/send_offer_view.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FreelancerProfileView extends StatefulWidget {
  final String freelancerId;
  const FreelancerProfileView({super.key, required this.freelancerId});

  @override
  _FreelancerProfileViewState createState() => _FreelancerProfileViewState();
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
  bool _isExpanded = false;
  int _currentPage = 0;
  late final PageController _servicePageController;

  @override
  void dispose() {
    _servicePageController
        .dispose(); // Dispose controller to prevent memory leaks
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _servicePageController = PageController();

    // Ensure the controller is only used when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _servicePageController.addListener(() {
          if (mounted) {
            setState(() {
              _currentPage = _servicePageController.page?.toInt() ?? 0;
            });
          }
        });
      }
    });
  }

  final PageController _reviewPageController = PageController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger event to load freelancer details, portfolio, and reviews
      BlocProvider.of<FreelancerProfileBloc>(context)
          .add(FetchFreelancerDetails(freelancerId: widget.freelancerId));
      //
    });

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color bookingButtonColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF7975D8);
        return BlocBuilder<FreelancerProfileBloc, FreelancerProfileState>(
          builder: (context, state) {
            if (state is FreelancerProfileLoaded) {
              final freelancer = state.freelancerEntity;
              final services = state.services;
              final portfolios = state.portfolios;
              final reviews = state.reviews;
              final education = state.education;
              final employment = state.employment;
              final appointments = state.appointments;
              String profilePictureUrl = freelancer.profilePicture ?? '';
              String bgPictureUrl = freelancer.backgroundPicture ?? '';
              List<String> skillList = freelancer.skills!.split(',');

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
                                child: bgPictureUrl.isNotEmpty
                                    ? Image.network(
                                        bgPictureUrl.contains('http')
                                            ? bgPictureUrl
                                            : 'http://localhost:3000/freelancer_images/$bgPictureUrl'
                                                .replaceFirst(
                                                    'localhost', '10.0.2.2'),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/swirls-8302543_640.jpg",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                bottom: -80,
                                left: 145,
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: CircleAvatar(
                                    backgroundImage: profilePictureUrl
                                            .isNotEmpty
                                        ? NetworkImage(
                                            profilePictureUrl.replaceFirst(
                                                'localhost', '10.0.2.2'))
                                        : const AssetImage(
                                                "assets/images/default_profile_img.png")
                                            as ImageProvider,
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
                            Text(
                              "${freelancer.firstName} ${freelancer.lastName}",
                              style: const TextStyle(
                                  fontFamily: "Inter Bold", fontSize: 22),
                            ),
                            Text(
                              "${freelancer.profession}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Color(0XFF707070),
                                    size: 20,
                                  ),
                                  Text(
                                    freelancer.mobileNo,
                                    style: const TextStyle(
                                        color: Color(0XFF707070), fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 160,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0XFF707070),
                                    size: 20,
                                  ),
                                  Text(
                                    "${freelancer.address} ${freelancer.city}",
                                    style: const TextStyle(
                                        color: Color(0XFF707070), fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CommonButton(
                                buttonText: "Book an Appointment",
                                buttonColor: bookingButtonColour,
                                onPressed: () {
                                  BlocProvider.of<FreelancerProfileBloc>(
                                          context)
                                      .add(NavigateToSendAnOffer(
                                          freelancerId:
                                              freelancer.freelancerId!,
                                          context: context,
                                          destination: SendOfferView(
                                              freelancerId:
                                                  freelancer.freelancerId!)));
                                }),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.event_available_outlined,
                                    size: 45,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        appointments.length.toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: "Inter SemiBold"),
                                      ),
                                      const Text(
                                        "bookings",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF707070)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.emoji_events_outlined,
                                    size: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${freelancer.yearsOfExperience!.toString()} years",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: "Inter SemiBold"),
                                      ),
                                      const Text(
                                        "experience",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF707070)),
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
                                _isExpanded
                                    ? freelancer.bio!
                                    : freelancer.bio!.length > 200
                                        ? '${freelancer.bio!.substring(0, 200)}...'
                                        : freelancer.bio!,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Services",
                                style: TextStyle(
                                    fontFamily: "Inter Bold", fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 290,
                                child: PageView.builder(
                                  controller: _servicePageController,
                                  itemCount: services.length,
                                  physics: const PageScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final service = services[index];

                                    final servicePortfolios = portfolios
                                        .where((portfolio) =>
                                            portfolio.freelancerService
                                                .freelancerServiceId ==
                                            service.freelancerServiceId)
                                        .map((portfolio) => portfolio.filePath)
                                        .expand((filePaths) => filePaths)
                                        .toList();

                                    return FreelancerProfileServiceContainer(
                                      title: service.service.serviceName,
                                      rate: service.hourlyRate,
                                      images: servicePortfolios,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SmoothPageIndicator(
                                  controller: _servicePageController,
                                  count: services.length,
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

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reviews",
                                style: TextStyle(
                                    fontFamily: "Inter Bold", fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 472, // Height for 4 reviews and spacing
                                child: PageView.builder(
                                  controller: _reviewPageController,
                                  itemCount: (reviews.length / 4).ceil(),
                                  itemBuilder: (context, pageIndex) {
                                    final startIndex = pageIndex * 4;
                                    final endIndex = startIndex + 4;
                                    final currentPageReviews = reviews.sublist(
                                        startIndex,
                                        endIndex > reviews.length
                                            ? reviews.length
                                            : endIndex);

                                    return Column(
                                      children:
                                          currentPageReviews.map((review) {
                                        final formattedReviewDate =
                                            DateFormat("dd-MM-yyyy")
                                                .format(review.reviewDate);
                                        return Column(
                                          children: [
                                            FreelancerProfileReviewContainer(
                                              projectTitle: review.appointment
                                                  .appointmentPurpose,
                                              rating: review.rating.toString(),
                                              reviewDate: formattedReviewDate,
                                              review: review.review,
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                              indent: 0,
                                              endIndent: 0,
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SmoothPageIndicator(
                                  controller: _reviewPageController,
                                  count: (reviews.length / 4).ceil(),
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

                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Skills",
                                  style: TextStyle(
                                      fontFamily: "Inter Bold", fontSize: 24)),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 333,
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 5.0,
                                      children: [
                                        for (var skill in skillList)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFCCCAFF),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              skill,
                                              style: const TextStyle(
                                                  color: Color(0xFF625D5D),
                                                  fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Education",
                                style: TextStyle(
                                    fontFamily: "Inter Bold", fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              // Wrap the mapped education list in a Column
                              Column(
                                children: education.map((edu) {
                                  String formattedStartDate =
                                      DateFormat('MMMM, yyyy')
                                          .format(edu.startDate);
                                  String formattedEndDate =
                                      DateFormat('MMMM, yyyy')
                                          .format(edu.endDate);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FreelancerProfileEducationContainer(
                                      degreeTitle: edu.degreeTitle,
                                      institutionName: edu.institutionName,
                                      startDate: formattedStartDate,
                                      endDate: formattedEndDate,
                                    ),
                                  );
                                }).toList(),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Employment",
                                  style: TextStyle(
                                      fontFamily: "Inter Bold", fontSize: 24)),
                              const SizedBox(height: 10),
                              Column(
                                children: employment.map((emp) {
                                  String formattedStartDate =
                                      DateFormat('MMMM, yyyy')
                                          .format(emp.startDate);
                                  String formattedEndDate = emp.endDate != null
                                      ? DateFormat('MMMM, yyyy')
                                          .format(emp.endDate!)
                                      : 'Present';
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FreelancerProfileEmploymentContainer(
                                      companyName: emp.companyName,
                                      jobTitle: emp.jobTitle,
                                      startDate: formattedStartDate,
                                      endDate: formattedEndDate,
                                      description: emp.description,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(""),
              );
            }
          },
        );
      },
    );
  }
}
