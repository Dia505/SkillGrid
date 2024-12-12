import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/view/client/client_registration_view.dart';
import 'package:skill_grid/view/login_screen_view.dart';

class JoinClientFreelancerView extends StatefulWidget {
  const JoinClientFreelancerView({super.key});

  @override
  State<JoinClientFreelancerView> createState() =>
      _JoinClientFreelancerViewState();
}

class _JoinClientFreelancerViewState extends State<JoinClientFreelancerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        color: const Color(0xFF322E86),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const CommonLogo(),

            Text("Join as a client or freelancer",
                style: GoogleFonts.caprasimo(
                    color: const Color(0xFFE7E7FF), fontSize: 20)),

            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF929292),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(13)),
              width: 330,
              height: 160,

              child: Card(
                color: const Color(0xFF322E86),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Image.asset(
                      "assets/images/join_as_client.png",
                      width: 95,
                      height: 135,
                    ),

                    SizedBox(
                      width: 170,
                      child: Text("I’m a client, hiring for a project",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 95),
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFF929292), width: 2.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF929292),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(13)),
              width: 330,
              height: 160,

              child: Card(
                color: const Color(0xFF322E86),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),

                child: Row(

                  children: [
                    Image.asset(
                      "assets/images/join_as_freelancer.png",
                      width: 140,
                      height: 125,
                    ),

                    SizedBox(
                      width: 151,
                      child: Text("I’m a freelancer, looking for work",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 95),
                      child: Container(
                        width: 17,
                        height: 17,

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFF929292), width: 2.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            CommonButton(
                buttonText: "Apply as Client",
                buttonColor: const Color(0xFFE7E7FF),
                buttonTextColor: const Color(0xFF322E86),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClientRegistrationView()));
                }),

            Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 85),
              child: Row(
                children: [
                  Text("Already have an account?",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFE7E7FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreenView()));
                    },
                    child: Text("Log in",
                        style: GoogleFonts.caprasimo(
                          color: const Color(0xFFE7E7FF),
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
