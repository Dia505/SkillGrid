import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';

class FreelancerProfileServiceContainer extends StatefulWidget {
  final String title;
  final int rate;
  final List<String> images;

  const FreelancerProfileServiceContainer({
    super.key,
    required this.title,
    required this.rate,
    required this.images,
  });

  @override
  State<FreelancerProfileServiceContainer> createState() =>
      _FreelancerProfileServiceContainerState();
}

class _FreelancerProfileServiceContainerState
    extends State<FreelancerProfileServiceContainer> {
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // Initialize here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 0), () {
        _scrollController
            .animateTo(
          _scrollController.offset + 2,
          duration: const Duration(milliseconds: 20),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent) {
            _scrollController.jumpTo(0);
          }
          _startAutoScroll();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color serviceTitleColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0XFF544FBD);
        Color serviceTitleUnderlineColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0XFF544FBD);
        return Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0XFF707070)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Title and Rate
              Text(
                "${widget.title} - Rs. ${widget.rate}/hr",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: serviceTitleColour,
                    fontFamily: "Inter Bold",
                    decoration: TextDecoration.underline,
                    decorationColor: serviceTitleUnderlineColour),
              ),
              const SizedBox(height: 15),
              // Continuous scrolling images
              SizedBox(
                height: 200,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.images.length * 100, // Infinite loop simulation
                  itemBuilder: (context, index) {
                    final imageIndex = index % widget.images.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        widget.images[imageIndex]
                            .replaceFirst('localhost', '10.0.2.2'),
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );},
    );
  }
}
