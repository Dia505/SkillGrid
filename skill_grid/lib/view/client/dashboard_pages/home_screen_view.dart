import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 240,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2F2A86),
                  Color(0xFF3D007F)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),

            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello John👋",style: TextStyle(color: Color(0xFFCCCAFF), fontSize: 17),),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/client_profile_img.jpg"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}