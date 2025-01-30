import 'package:flutter/material.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_edit_view.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile",
              style: TextStyle(
                  color: Color(0xFFE7E7FF),
                  fontSize: 24,
                  fontFamily: "Caprasimo")),
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFF322E86),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: SafeArea(
              child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage:
                      AssetImage("assets/images/client_profile_img.jpg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ClientProfileEditView()));
                    },
                    child: const Text("Edit profile")),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style:
                              TextStyle(fontSize: 19, fontFamily: "Inter Bold"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "firstName + lastName",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone",
                          style:
                              TextStyle(fontSize: 19, fontFamily: "Inter Bold"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "mobileNo",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "City",
                          style:
                              TextStyle(fontSize: 19, fontFamily: "Inter Bold"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "city",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style:
                              TextStyle(fontSize: 19, fontFamily: "Inter Bold"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "email",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
        ));
  }
}
