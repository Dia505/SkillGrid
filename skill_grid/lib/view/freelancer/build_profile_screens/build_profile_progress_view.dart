import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/bio_form_view.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/job_category_view.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/job_details_view.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/services_form_view.dart';

class BuildProfileProgressView extends StatefulWidget {
  const BuildProfileProgressView({super.key});

  @override
  State<BuildProfileProgressView> createState() => _BuildProfileProgressViewState();
}

class _BuildProfileProgressViewState extends State<BuildProfileProgressView> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Animation controller for smooth progress bar animation
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and progress animation
    _progressController = AnimationController(
      vsync: this,  // 'this' refers to the current state which is a ticker provider
      duration: const Duration(milliseconds: 300),
    );

     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // Initialize the progress bar animation to match the current step
    _progressController.value = (_currentStep + 1) / _totalSteps;
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Animate the progress bar smoothly
      _progressController.animateTo(
        (_currentStep + 1) / _totalSteps,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Animate the progress bar smoothly
       _progressController.animateTo(
        (_currentStep + 1) / _totalSteps,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Build Your Profile",
            style: GoogleFonts.caprasimo(
                color: const Color(0xFFE7E7FF), fontSize: 24)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF322E86),
      ),
      body: Column(
        children: [
          // Smooth progress bar animation
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressAnimation.value,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF524DB3),
                minHeight: 5,
                
              );
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int step) {
                setState(() {
                  _currentStep = step;
                });

                // Animate the progress bar smoothly when the page changes
                _progressController.animateTo(
                  (_currentStep + 1) / _totalSteps,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              children: const [
                JobCategoryView(),
                JobDetailsView(),
                ServicesFormView(),
                BioFormView()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousStep,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: const Color(0xFF322E86),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFFE7E7FF),
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: CommonButton(
                    buttonText: "Next",
                    buttonColor: const Color(0xFF322E86),
                    buttonTextColor: const Color(0xFFE7E7FF),
                    onPressed: _nextStep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
