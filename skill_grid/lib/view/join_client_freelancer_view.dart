import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/view/client/client_registration_view.dart';
import 'package:skill_grid/view/freelancer/freelancer_registration_view.dart';
import 'package:skill_grid/view/login_screen_view.dart';

class JoinClientFreelancerView extends StatefulWidget {
  const JoinClientFreelancerView({super.key});

  @override
  State<JoinClientFreelancerView> createState() =>
      _JoinClientFreelancerViewState();
}

class _JoinClientFreelancerViewState extends State<JoinClientFreelancerView> {
  bool _isClientSelected = false;
  bool _isFreelancerSelected = false;

  Color _clientBorderColor = const Color(0xFF929292);
  Color _freelancerBorderColor = const Color(0xFF929292);
  Color _clientCircleBorderColor = const Color(0xFF929292);
  Color _freelancerCircleBorderColor = const Color(0xFF929292);
  Color _clientCircleColor = const Color(0xFF322E86);
  Color _freelancerCircleColor = const Color(0xFF322E86);

  void _toggleClientSelection() {
    setState(() {
       _isClientSelected = !_isClientSelected;

      if (_isClientSelected) {
        _clientBorderColor = const Color(0xFFE7E7FF);
        _clientCircleBorderColor = const Color(0xFFE7E7FF); 
        _clientCircleColor = const Color(0xFFE7E7FF); 
      } 
      else {
        _clientBorderColor = const Color(0xFF929292);
        _clientCircleBorderColor = const Color(0xFF929292); 
        _clientCircleColor = const Color(0xFF322E86);
      }

      if (_isClientSelected) {
        _isFreelancerSelected = false;
        _freelancerBorderColor = const Color(0xFF929292);
        _freelancerCircleBorderColor = const Color(0xFF929292); 
        _freelancerCircleColor = const Color(0xFF322E86);
      }
    });
  }

  void _toggleFreelancerSelection() {
    setState(() {
      _isFreelancerSelected = !_isFreelancerSelected;

      if (_isFreelancerSelected) {
        _freelancerBorderColor = const Color(0xFFE7E7FF);
        _freelancerCircleBorderColor = const Color(0xFFE7E7FF); 
        _freelancerCircleColor = const Color(0xFFE7E7FF); 
      } 
      else {
        _freelancerBorderColor = const Color(0xFF929292);
        _freelancerCircleBorderColor = const Color(0xFF929292); 
        _freelancerCircleColor = const Color(0xFF322E86);
      }

      if (_isFreelancerSelected) {
        _isClientSelected = false;
        _clientBorderColor = const Color(0xFF929292);
        _clientCircleBorderColor = const Color(0xFF929292); 
        _clientCircleColor = const Color(0xFF322E86);
      }
    });
  }

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

            const Text("Join as a client or freelancer",
                style: TextStyle(
                    color: Color(0xFFE7E7FF), fontSize: 20, fontFamily: "Caprasimo")),

            GestureDetector(
              onTap: _toggleClientSelection,

              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: _clientBorderColor,
                      width: 3.0,
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
              
                      const SizedBox(
                        width: 170,
                        child: Text("I’m a client, hiring for a project",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Inter SemiBold")),
                      ),
              
                      Padding(
                        padding: const EdgeInsets.only(bottom: 95),
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _clientCircleBorderColor, width: 2.0),
                              color: _clientCircleColor
                            ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _toggleFreelancerSelection,

              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: _freelancerBorderColor,
                      width: 3.0,
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
              
                      const SizedBox(
                        width: 151,
                        child: Text("I’m a freelancer, looking for work",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Inter SemiBold")),
                      ),
              
                      Padding(
                        padding: const EdgeInsets.only(bottom: 95),
                        child: Container(
                          width: 17,
                          height: 17,
              
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _freelancerCircleBorderColor, width: 2.0),
                            color: _freelancerCircleColor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            CommonButton(
              buttonText: _isClientSelected
                ? "Join as Client"
                : _isFreelancerSelected
                  ? "Apply as Freelancer"
                  : "Create Account",
                  
              buttonColor: _isClientSelected || _isFreelancerSelected
                  ? const Color(0xFFE7E7FF) // Active color when a role is selected
                  : const Color(0xFF929292), // Grey color when no role is selected

              buttonTextColor: _isClientSelected || _isFreelancerSelected
                  ? const Color(0xFF322E86) // Text color when a role is selected
                  : const Color(0xFFD3CDCD), // Grey text color when no role is selected

              onPressed: (_isClientSelected || _isFreelancerSelected) ? 
              () {
                  if (_isClientSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ClientRegistrationView()),
                    );
                  } 
                  else if (_isFreelancerSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FreelancerRegistrationView()),
                    );
                  }
                }
              : (){}
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 85),
              child: Row(
                children: [
                  const Text("Already have an account?",
                      style: TextStyle(
                        color: const Color(0xFFE7E7FF),
                        fontSize: 14,
                        fontFamily: "Inter Medium"
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
                    child: const Text("Log in",
                        style: TextStyle(
                          color: const Color(0xFFE7E7FF),
                          fontSize: 14,
                          fontFamily: "Caprasimo"
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
