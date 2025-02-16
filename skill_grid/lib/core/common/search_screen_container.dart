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
  final List<String> skills;

  const SearchScreenContainer(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerName,
      required this.profession,
      required this.address,
      required this.hourlyRate,
      required this.searchScreenImages,
      required this.skills});

  @override
  _SearchScreenContainerState createState() => _SearchScreenContainerState();
}

class _SearchScreenContainerState extends State<SearchScreenContainer> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    activeIndex = activeIndex >= widget.searchScreenImages.length
        ? widget.searchScreenImages.length - 1
        : activeIndex;

    return Container(
      height: 430,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundImage: widget
                              .freelancerProfileImgPath.isNotEmpty
                          // ? Image.network()
                          ? NetworkImage(
                              "http://10.0.2.2:3000/freelancer_images/${widget.freelancerProfileImgPath}") // Adjust base URL
                          : const AssetImage(
                                  "assets/images/default_profile_img.png")
                              as ImageProvider,
                      radius: 40),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.freelancerName,
                        style: const TextStyle(
                            fontFamily: "Inter Bold", fontSize: 19),
                      ),
                      Text(
                        widget.profession,
                        style: const TextStyle(
                            fontSize: 15, fontFamily: "Inter Medium"),
                      ),
                      Text(
                        widget.address,
                        style: const TextStyle(
                            color: Color(0XFF707070), fontSize: 13),
                      ),
                    ],
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
              print("Image FilepATHHH: $carouselData");
              return buildSearchImage(carouselData, index);
            },
          ),
          buildIndicator(),
          const SizedBox(
            height: 10,
          ),
          buildSkillsSection(widget.skills),
        ],
      ),
    );
  }

  Widget buildSearchImage(String carouselData, int index) {
    return Container(
      width: 266,
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          carouselData, // Dynamically get image from carouselData
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  //Indicator for the carousel
  Widget buildIndicator() {
    if (widget.searchScreenImages.isEmpty) {
      return Container(); // Return an empty container if no images are available
    }

    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: widget.searchScreenImages.length,
      effect: const JumpingDotEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Color(0xFF8984F2),
        dotColor: Colors.grey,
      ),
    );
  }

  Widget buildSkillsSection(List<String> skills) {
    const int maxSkillsToShow = 4; // Show up to 6 skills before showing "+X"

    // If there are more than maxSkillsToShow skills, show the rest as "+X"
    List<String> displayedSkills = skills.length > maxSkillsToShow
        ? skills.sublist(0, maxSkillsToShow)
        : skills;

    int remainingSkillsCount = skills.length - displayedSkills.length;

    return SizedBox(
      width: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0, //horizontal spacing between each item
            runSpacing: 5.0, //vertical spacing between each row
            children: [
              for (var skill in displayedSkills)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCCAFF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    skill,
                    style:
                        const TextStyle(color: Color(0xFF625D5D), fontSize: 12),
                  ),
                ),
              if (remainingSkillsCount > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCCAFF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "+$remainingSkillsCount",
                    style:
                        const TextStyle(color: Color(0xFF625D5D), fontSize: 12),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
