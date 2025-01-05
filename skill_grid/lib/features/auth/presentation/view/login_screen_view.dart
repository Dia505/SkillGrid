import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/core/common/common_textfield.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  bool _isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
        
            Positioned(
              top: 0,
              left: 0,
              right: 0,
        
              child: Container(
                color: const Color(0xFF322E86),
                height: 250,
              
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: CommonLogo())
              ),
            ),
        
            Form(
              key: _formKey,
      
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                
                child: Container(
                  height: 659,
                  padding: const EdgeInsets.only(left: 45, top: 70),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7E7FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero
                    ),
                  ),
                
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                
                    children: [
                      const Text("Welcome Back!",
                          style: TextStyle(
                              color: Color(0xFF322E86), fontSize: 26, fontFamily: "Caprasimo")),
                
                      const SizedBox(
                        height: 10,
                      ),
                
                      const Text("Log in to your account",
                          style: TextStyle(
                              color: Color(0xFF322E86), fontSize: 17)),
                
                      const SizedBox(height: 50),
                
                      CommonTextfield(
                        textFieldTitle: "Email address",
                        controller: _emailController,
              
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
              
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          
                          return null;
                        },),
                
                      CommonTextfield(
                        textFieldTitle: "Password",
                        obscureText: true,
              
                        controller: _passwordController,
              
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          
                          return null;
                        },
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
                
                              const Text('Remember me',
                              style: TextStyle(
                                color: Color(0xFF322E86), fontSize: 15)),
                            ],
                          ),
                
                          const SizedBox(width: 50),
                
                          const Text('Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF322E86), fontSize: 15)),
                        ],
                      ),
                
                      const SizedBox(height: 50),
                
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: CommonButton(
                          buttonText: "Log In",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientDashboard()));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
