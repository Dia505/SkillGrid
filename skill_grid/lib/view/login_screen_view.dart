import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_grid/core/common/common_textfield.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF322E86),
          ),

          Container(
            width: double.infinity,
            height: 659,
            padding: const EdgeInsets.only(left: 45, top: 70),
            decoration: BoxDecoration(
              color: const Color(0xFFE7E7FF),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Welcome Back!",
                    style: GoogleFonts.caprasimo(
                        color: const Color(0xFF322E86), fontSize: 26)),

                const SizedBox(
                  height: 10,
                ),

                Text("Log in to your account",
                    style: GoogleFonts.inter(
                        color: const Color(0xFF322E86), fontSize: 17)),

                const SizedBox(height: 50),

                const CommonTextfield(textFieldTitle: "Email address"),

                const CommonTextfield(
                  textFieldTitle: "Password",
                  obscureText: true,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          side: const BorderSide(
                            color: Color(0xFF322E86)
                          ),
                        ),

                        Text('Remember me',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF322E86), fontSize: 14)),
                      ],
                    ),

                    const SizedBox(width: 50),

                    Text('Forgot Password',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF322E86), fontSize: 14)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
