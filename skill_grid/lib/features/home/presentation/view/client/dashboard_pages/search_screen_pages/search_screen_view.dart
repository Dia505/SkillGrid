import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/search_screen_container.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_filter_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view/freelancer_profile_view.dart';

class SearchScreenView extends StatefulWidget {
  final String searchQuery;
  const SearchScreenView({super.key, this.searchQuery = ''});

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
                    onChanged: (searchQuery) {
                      context
                          .read<SearchBloc>()
                          .add(SearchFreelancers(searchQuery));
                    },
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
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchError) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
                  child: Center(
                      child: Column(children: [
                    Image.asset(
                      "assets/images/no_result_found.png",
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Looks like there are no results for that. Keep searching!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ])),
                );
              } else if (state is SearchLoaded) {
                if (state.freelancers.isEmpty) {
                  return Center(
                      child: Column(children: [
                    Image.asset(
                      "assets/images/no_result_found.png",
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Looks like there are no results for that. Keep searching!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ]));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight +
                            40), // Ensures content is above nav bar
                    physics:
                        const AlwaysScrollableScrollPhysics(), // Enables scrolling even if few results
                    shrinkWrap:
                        true, // Tells the ListView to take as much space as needed
                    itemCount: state.freelancers.length,
                    itemBuilder: (context, index) {
                      final freelancer = state.freelancers[index];

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FreelancerProfileView(),
                                ),
                              );
                            },
                            child: SearchScreenContainer(
                              freelancerProfileImgPath:
                                  freelancer.profilePicture ??
                                      "assets/images/default_profile_img.png",
                              freelancerName:
                                  '${freelancer.firstName} ${freelancer.lastName}',
                              profession: freelancer.profession ?? "",
                              address:
                                  '${freelancer.address}, ${freelancer.city}',
                              hourlyRate: 1500,
                              searchScreenImages: const [
                                "assets/images/gettyimages-480952865-612x612.jpg",
                                "assets/images/panel-discussion-event-stockcake.jpg",
                                "assets/images/istockphoto-1137781483-612x612.jpg"
                              ],
                              skills: freelancer.skills
                                      ?.split(',')
                                      .map((e) => e.trim())
                                      .toList() ??
                                  [],
                            ),
                          ),
                          if (index != state.freelancers.length - 1)
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                        ],
                      );
                    },
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
                child: Center(
                    child: Column(children: [
                  Image.asset(
                    "assets/images/search_freelancer_initial.png",
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Discover talent to help you grow🚀",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18, fontFamily: "Inter SemiBold"),
                  ),
                ])),
              );
            },
          ),
        ],
      )),
    );
  }
}
