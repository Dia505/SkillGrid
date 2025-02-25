import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/features/auth/presentation/view_model/send_otp/send_otp_bloc.dart';

class SendOtpView extends StatelessWidget {
  SendOtpView({super.key});

  final TextEditingController _emailController = TextEditingController();
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
                      alignment: Alignment.topCenter, child: CommonLogo())),
            ),
            Form(
              key: _formKey,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 659,
                  padding: const EdgeInsets.only(left: 45, top: 60, right: 45),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7E7FF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Forgot password?",
                          style: TextStyle(
                              color: Color(0xFF322E86),
                              fontSize: 26,
                              fontFamily: "Caprasimo")),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Enter your email to receive an OTP",
                          style: TextStyle(
                              color: Color(0xFF322E86), fontSize: 17)),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: BlocBuilder<SendOtpBloc, SendOtpState>(
                            builder: (context, state) {
                          return state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButton(
                                  buttonText: "Get OTP",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<SendOtpBloc>().add(
                                          SendEmailEvent(
                                              context: context,
                                              email: _emailController.text
                                                  .trim()));
                                    }
                                  },
                                );
                        }),
                      ),
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
