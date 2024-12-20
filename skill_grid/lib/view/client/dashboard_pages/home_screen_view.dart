import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final _searchController = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 290,
            padding: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF2F2A86), Color(0xFF3D007F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello John👋",
                        style:
                            TextStyle(color: Color(0xFFCCCAFF), fontSize: 17),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("assets/images/client_profile_img.jpg"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontSize: 14,
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
                              backgroundColor: const Color(0XFF7C76E4),
                              padding: EdgeInsets.zero),
                          child: const Icon(Icons.search),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                const Text(
                  "Service Category",
                  style: TextStyle(fontSize: 22, fontFamily: "Inter Light"),
                ),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: serviceCategory.asMap().entries.map((entry) {
                      int index = entry.key; // Access index
                      var category = entry.value; // Access the map (category)

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xFF03006F),
                              child: Icon(category['icon'], size: 30, color: Colors.white,)
                            ), // Access the icon from the map

                            const SizedBox(height: 8),

                            Text(category['label'], style: const TextStyle(fontSize: 16)), // Access the label from the map
                          ],
                        ),
                      );
                    }).toList(), // Converts the iterable to a list of widgets
                  ),
                ),

                const Text(
                  "Recently Viewed",
                  style: TextStyle(fontSize: 22, fontFamily: "Inter Light"),
                ),

                
              ],
            ),
          )
        ],
      )),
    );
  }
}
