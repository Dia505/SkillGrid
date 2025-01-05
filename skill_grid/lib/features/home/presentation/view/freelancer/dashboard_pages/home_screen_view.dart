import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/freelancer_dashboard_stat_card.dart';
import 'package:skill_grid/core/common/home_ongoing_collab_card.dart';
import 'package:skill_grid/core/common/home_recent_invoice_card.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 270,
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xFF2F2A86), Color(0xFF3D007F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hello Krishna👋",
                            style: TextStyle(
                                color: Color(0xFFCCCAFF), fontSize: 17),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                "assets/images/istockphoto-1395071229-612x612.jpg"),
                          )
                        ],
                      ),
                      Text(
                        "Showcase your skills and connect with clients who value your expertise",
                        style: TextStyle(
                            fontFamily: "Caprasimo",
                            fontSize: 20,
                            color: Color(0xFFE7E7FF)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FreelancerDashboardStatCard(
                            cardDashboardEmoji: "💰",
                            cardDashboardValue: "Rs. 20,000",
                            cardDashboardTopic: "Total earnings this year"),
                        FreelancerDashboardStatCard(
                            cardDashboardEmoji: "🚀",
                            cardDashboardValue: "22",
                            cardDashboardTopic:
                                "Total projects delivered this year"),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, top: 10, bottom: 10),
                      child: SizedBox(
                        width: 350,
                        height: 180,
                        child: Card(
                          color: const Color(0XFF322E86),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Average ratings this year",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Inter SemiBold",
                                      color: Colors.white),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          "4",
                                          style: TextStyle(
                                              fontSize: 50,
                                              fontFamily: "Inter Bold",
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "out of 5",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0XFFC8C8C8)),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 13),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "⭐⭐⭐⭐⭐",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: const SizedBox(
                                                  width: 143,
                                                  height: 8,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 60 / 100,
                                                    backgroundColor:
                                                        Color(0xFFE1E1E1),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF8984F2)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "⭐⭐⭐⭐",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: const SizedBox(
                                                  width: 143,
                                                  height: 8,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 85 / 100,
                                                    backgroundColor:
                                                        Color(0xFFE1E1E1),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF8984F2)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "⭐⭐⭐",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: const SizedBox(
                                                  width: 143,
                                                  height: 8,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 40 / 100,
                                                    backgroundColor:
                                                        Color(0xFFE1E1E1),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF8984F2)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "⭐⭐",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: const SizedBox(
                                                  width: 143,
                                                  height: 8,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 0 / 100,
                                                    backgroundColor:
                                                        Color(0xFFE1E1E1),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF8984F2)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "⭐",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: const SizedBox(
                                                  width: 143,
                                                  height: 8,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 0 / 100,
                                                    backgroundColor:
                                                        Color(0xFFE1E1E1),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF8984F2)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ongoing Collaborations",
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Inter Light"),
                          ),
                          SizedBox(height: 10),
                          HomeOngoingCollabCard(
                            freelancerProfileImgPath:
                                "assets/images/1000_F_463221858_50KkvfxxovUaMNlilCmUxrOnTqSpzAlP.jpg",
                            freelancerName: "Akash Thapa",
                            projectName: "Herald College Graduation",
                            deadlineDuration: "2 hours",
                            completePercent: 65,
                          ),
                          SizedBox(height: 10),
                          HomeOngoingCollabCard(
                              freelancerProfileImgPath:
                                  "assets/images/istockphoto-1313502972-612x612.jpg",
                              freelancerName: "Susanna Acharya",
                              projectName: "Susanna Birthday Photoshoot",
                              deadlineDuration: "6 hours",
                              completePercent: 0),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 7, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recent invoice",
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Inter Light"),
                          ),
                          SizedBox(height: 10),
                          HomeRecentInvoiceCard(
                            freelancerProfileImgPath:
                                "assets/images/1000_F_463221858_50KkvfxxovUaMNlilCmUxrOnTqSpzAlP.jpg",
                            freelancerName: "Akash Thapa",
                            projectName: "Herald College Graduation",
                            amount: 3500,
                          ),
                          SizedBox(height: 10),
                          HomeRecentInvoiceCard(
                            freelancerProfileImgPath:
                                "assets/images/portrait-handsome-indian-man-gray-260nw-2031910466.jpg",
                            freelancerName: "Samuel Fuller",
                            projectName:
                                "Coventry University marketing photoshoot",
                            amount: 5000,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
