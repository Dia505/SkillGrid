import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/search_screen_container.dart';

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
                  onPressed: () {},
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
          const SearchScreenContainer(
            freelancerProfileImgPath: "assets/images/istockphoto-1395071229-612x612.jpg", 
            freelancerName: "Krishna Basnet", 
            profession: "Photographer & Videographer", 
            address: "Kalimati, Kathmandu", 
            hourlyRate: 1500,
            searchScreenImages: [
              "assets/images/gettyimages-480952865-612x612.jpg",
              "assets/images/panel-discussion-event-stockcake.jpg",
              "assets/images/istockphoto-1137781483-612x612.jpg"
            ],
          )
        ],
      )),
    );
  }
}
