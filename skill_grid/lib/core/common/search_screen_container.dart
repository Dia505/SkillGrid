import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchScreenContainer extends StatefulWidget {
  final String freelancerProfileImgPath;
  final String freelancerName;
  final String profession;
  final String address;
  final int hourlyRate;
  final List<String> searchScreenImages;

  const SearchScreenContainer(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerName,
      required this.profession,
      required this.address,
      required this.hourlyRate,
      required this.searchScreenImages});

  @override
  _SearchScreenContainerState createState() => _SearchScreenContainerState();
}

class _SearchScreenContainerState extends State<SearchScreenContainer> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.freelancerProfileImgPath),
                radius: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.freelancerName,
                    style:
                        const TextStyle(fontFamily: "Inter Bold", fontSize: 19),
                  ),
                  Text(
                    widget.profession,
                    style: const TextStyle(
                        fontSize: 15, fontFamily: "Inter Medium"),
                  ),
                  Text(
                    widget.address,
                    style:
                        const TextStyle(color: Color(0XFF707070), fontSize: 13),
                  ),
                ],
              ),
              Text(
                "Rs. ${widget.hourlyRate}/hr",
                style:
                    const TextStyle(fontSize: 13, fontFamily: "Inter SemiBold"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 166,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemCount: widget.searchScreenImages.length,
            itemBuilder: (context, index, realIndex) {
              final carouselData = widget.searchScreenImages[index];
              return buildSearchImage(carouselData, index);
            },
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildSearchImage(String carouselData, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child:
            Image.asset(carouselData, // Dynamically get image from carouselData
                fit: BoxFit.cover),
      ),
    );
  }

  // Indicator for the carousel
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.searchScreenImages.length,
        effect: const JumpingDotEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: Color(0xFF544FBD),
          dotColor: Colors.grey,
        ),
      );
}
