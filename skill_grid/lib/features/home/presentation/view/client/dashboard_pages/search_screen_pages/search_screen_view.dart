import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/search_screen_container.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/freelancer_profile_view.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_filter_view.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: 314,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(fontSize: 15),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color(0XFF707070), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color(0xFF707070), width: 2),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Makes the sheet scrollable if content is long
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => const SearchFilterView(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Color(0xFF544FBD),
                            width: 3,
                          ),
                        ),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: const Color(0xFFE7E7FF),
                        fixedSize: const Size(50, 50)),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF544FBD),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FreelancerProfileView(),
                  ),
                );
              },
              child: const SearchScreenContainer(
                freelancerProfileImgPath:
                    "assets/images/istockphoto-1395071229-612x612.jpg",
                freelancerName: "Krishna Basnet",
                profession: "Photographer & Videographer",
                address: "Kalimati, Kathmandu",
                hourlyRate: 1500,
                searchScreenImages: [
                  "assets/images/gettyimages-480952865-612x612.jpg",
                  "assets/images/panel-discussion-event-stockcake.jpg",
                  "assets/images/istockphoto-1137781483-612x612.jpg"
                ],
                skills: [
                  "Event Photography",
                  "Commercial Photography",
                  "Videography",
                  "Adobe photoshop",
                  "Davinci resolve",
                  "Professional photoshoots"
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20, // Space before the line (left)
              endIndent: 20, // Space after the line (right)
            ),
            const SearchScreenContainer(
              freelancerProfileImgPath:
                  "assets/images/gettyimages-484274251-612x612.jpg",
              freelancerName: "Amaira Yadav",
              profession: "Photographer",
              address: "Maharajgunj, Kathmandu",
              hourlyRate: 5000,
              searchScreenImages: [
                "assets/images/Screenshot 2024-12-01 003357.png",
                "assets/images/98f8b4e72c6023a2a15dfdab64a1a80c.jpg",
                "assets/images/gettyimages-1386266678-612x612.jpg"
              ],
              skills: [
                "Fashion Photography",
                "Commercial Photography",
                "Photo editing",
                "Adobe photoshop",
                "Professional photoshoots"
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20, // Space before the line (left)
              endIndent: 20, // Space after the line (right)
            ),
            const SearchScreenContainer(
              freelancerProfileImgPath:
                  "assets/images/indian_girl_stock_img.jpg",
              freelancerName: "Rita Singh",
              profession: "Photographer",
              address: "Sanepa, Lalitpur",
              hourlyRate: 3000,
              searchScreenImages: [
                "assets/images/food-photographer-ideas.jpg",
                "assets/images/gettyimages-1829241109-612x612.jpg",
                "assets/images/istockphoto-1394055240-612x612.jpg"
              ],
              skills: [
                "Food Photography",
                "Commercial Photography",
                "Photo editing",
                "Adobe photoshop"
              ],
            ),
          ],
        )),
      ),
    );
  }
}
