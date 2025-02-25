import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/core/common/common_textfield.dart';
import 'package:skill_grid/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;
  final String otp;
  ResetPasswordView({super.key, required this.email, required this.otp});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                  padding: const EdgeInsets.only(left: 45, top: 60),
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
                      const Text("Reset password",
                          style: TextStyle(
                              color: Color(0xFF322E86),
                              fontSize: 26,
                              fontFamily: "Caprasimo")),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Create a strong password for your account",
                          style: TextStyle(
                              color: Color(0xFF322E86), fontSize: 17)),
                      const SizedBox(height: 30),
                      CommonTextfield(
                        textFieldTitle: "New password",
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }

                          return null;
                        },
                      ),
                      CommonTextfield(
                        textFieldTitle: "Confirm password",
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter the password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child:
                            BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                                builder: (context, state) {
                          return state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButton(
                                  buttonText: "Update password",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<ResetPasswordBloc>().add(
                                          ChangePasswordEvent(
                                              context: context,
                                              email: email,
                                              otp: otp,
                                              newPassword: _passwordController
                                                  .text
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
