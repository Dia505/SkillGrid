import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/features/auth/presentation/view/client_registration_view.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/onboard_screen/onboard_screen_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreenView extends StatefulWidget {
  const OnboardScreenView({super.key});

  @override
  State<OnboardScreenView> createState() => _OnboardScreenViewState();
}

class _OnboardScreenViewState extends State<OnboardScreenView> {
  int activeIndex = 0;
  final onboardCarouselData = [
    {
      "image": "assets/images/onboard_screen_img.png",
      "title": "Where Skills Find Purpose",
      "subtitle": "Connecting clients and freelancers for impactful projects"
    },
    {
      "image": "assets/images/onboard_screen_img2.png",
      "title": "Connect with Top Freelancers",
      "subtitle":
          "Find skilled professionals effortlessly and get your projects done with confidence"
    },
    {
      "image": "assets/images/onboard_screen_img3.png",
      "title": "Find Work with Trusted Clients",
      "subtitle":
          "Discover reliable opportunities and grow your career effortlessly"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF322E86),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonLogo(),
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 386,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemCount: onboardCarouselData.length,
              itemBuilder: (context, index, realIndex) {
                final carouselData = onboardCarouselData[index];
                return buildImageWithText(carouselData, index);
              },
            ),
            buildIndicator(),
            CommonButton(
              buttonText: "Log In",
              buttonColor: const Color(0xFFE7E7FF),
              buttonTextColor: const Color(0xFF322E86),
              onPressed: () {
                context
                    .read<OnboardScreenCubit>()
                    .navigateToLoginScreen(context, const LoginScreenView());
              },
            ),
            Container(
              width: 210,
              padding: const EdgeInsets.only(bottom: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New to SkillGrid?",
                    style: TextStyle(color: Color(0xFFE7E7FF), fontSize: 17),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<OnboardScreenCubit>()
                          .navigateToRegistrationEvent(
                              context, const ClientRegistrationView());
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Color(0xFFE7E7FF),
                          fontSize: 17,
                          fontFamily: "Caprasimo"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageWithText(Map<String, String> carouselData, int index) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            carouselData["image"]!,
            fit: BoxFit.cover,
            height: 266,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            carouselData["title"]!,
            style: const TextStyle(
                color: Color(0xFFE7E7FF),
                fontSize: 20,
                fontFamily: "Caprasimo"),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          width: 320,
          child: Text(
            carouselData["subtitle"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFFE7E7FF),
                fontSize: 15,
                fontFamily: "Inter Medium"),
          ),
        ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: onboardCarouselData.length,
        effect: const ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: Color(0xFFE7E7FF),
          dotColor: Colors.grey,
        ),
      );
}
