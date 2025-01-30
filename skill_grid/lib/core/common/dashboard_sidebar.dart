import 'package:flutter/material.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: const Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage("assets/images/client_profile_img.jpg"),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Client full name",
                    style: TextStyle(fontSize: 20, fontFamily: "Inter Bold"),
                  ),
                  Text(
                    "Client",
                    style: TextStyle(color: Color(0xFF707070), fontSize: 16),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline_sharp,
                    size: 28,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Profile",
                    style:
                        TextStyle(fontSize: 18, fontFamily: "Inter SemiBold"),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 80.0),
            child: Row(
              children: [
                Icon(Icons.logout, size: 28, color: Color(0XFF322E86)),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Log out",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Inter SemiBold",
                      color: Color(0XFF322E86)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
