import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/core/common/common_textfield.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';

class FreelancerRegistrationView extends StatefulWidget {
  const FreelancerRegistrationView({super.key});

  @override
  State<FreelancerRegistrationView> createState() =>
      _FreelancerRegistrationViewState();
}

class _FreelancerRegistrationViewState
    extends State<FreelancerRegistrationView> {
  bool _isChecked = false;

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _mobNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final cityList = [
    const DropdownMenuItem(value: "Kathmandu", child: Text("Kathmandu")),
    const DropdownMenuItem(value: "Lalitpur", child: Text("Lalitpur")),
    const DropdownMenuItem(value: "Bhaktapur", child: Text("Bhaktapur")),
    const DropdownMenuItem(value: "Pokhara", child: Text("Pokhara")),
    const DropdownMenuItem(value: "Chitwan", child: Text("Chitwan")),
    const DropdownMenuItem(value: "Lumbini", child: Text("Lumbini")),
    const DropdownMenuItem(value: "Janakpur", child: Text("Janakpur")),
    const DropdownMenuItem(value: "Biratnagar", child: Text("Biratnagar")),
    const DropdownMenuItem(value: "Dharan", child: Text("Dharan")),
    const DropdownMenuItem(value: "Butwal", child: Text("Butwal")),
  ];

  String? city;
  String? month;
  DateTime? selectedDate;
  String? dateError;

  void _showDatePicker() {
    DateTime firstDate = DateTime(1960, 1, 1);
    DateTime lastDate = DateTime(2006, 1, 1);

    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000, 1, 1),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  void _validateForm() {
    setState(() {
      // Set error messages if date or time is not selected
      dateError = selectedDate == null ? '*required' : null;
    });

    if (_formKey.currentState!.validate() && selectedDate != null) {
      context.read<FreelancerBloc>().add(RegisterFreelancer(
          context: context,
          firstName: _fnameController.text.trim(),
          lastName: _lnameController.text.trim(),
          dateOfBirth: selectedDate!,
          mobileNo: _mobNumberController.text.trim(),
          address: _addressController.text.trim(),
          city: city!,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          available: true));
    }
  }

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
                top: 200,
                bottom: 0,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(left: 45, top: 40),
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
                        const Text("Sign Up",
                            style: TextStyle(
                                color: Color(0xFF322E86),
                                fontSize: 26,
                                fontFamily: "Caprasimo")),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Find the work you love",
                            style: TextStyle(
                                color: Color(0xFF322E86), fontSize: 16)),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            CommonTextfield(
                              textFieldTitle: "First name",
                              controller: _fnameController,
                              width: 185,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*required';
                                }

                                return null;
                              },
                            ),
                            CommonTextfield(
                              textFieldTitle: "Last name",
                              controller: _lnameController,
                              width: 181,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*required';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          child: const Text("Date of birth",
                              style: TextStyle(
                                  color: Color(0xFF322E86), fontSize: 15)),
                        ),
                        const SizedBox(height: 7),
                        ElevatedButton(
                          onPressed: _showDatePicker,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFFE7E7FF),
                              fixedSize: const Size(160, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Color(0xFF322E86)))),
                          child: Text(
                            selectedDate != null
                                ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                                : "Choose date",
                            style: const TextStyle(
                                color: Color(0xFF322E86),
                                fontSize: 17,
                                fontFamily: "Inter SemiBold"),
                          ),
                        ),
                        if (dateError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Text(
                              dateError!,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 185, 37, 27),
                                  fontSize: 13),
                            ),
                          ),
                        const SizedBox(height: 10),
                        CommonTextfield(
                          textFieldTitle: "Mobile number",
                          controller: _mobNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*required';
                            }

                            if (!RegExp(r'^(98|97|96)\d{8}$').hasMatch(value)) {
                              return 'Enter a valid mobile number';
                            }

                            return null;
                          },
                        ),
                        Row(
                          children: [
                            CommonTextfield(
                              textFieldTitle: "Address",
                              controller: _addressController,
                              width: 200,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*required';
                                }

                                return null;
                              },
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 80),
                                  child: const Text("City",
                                      style: TextStyle(
                                          color: Color(0xFF322E86),
                                          fontSize: 15)),
                                ),
                                const SizedBox(height: 7),
                                CommonDropdown(
                                  width: 140,
                                  items: cityList,
                                  onChanged: (value) {
                                    if (value != null) {
                                      city = value;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        CommonTextfield(
                          textFieldTitle: "Email address",
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*required';
                            }

                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }

                            return null;
                          },
                        ),
                        CommonTextfield(
                          textFieldTitle: "Password",
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*required';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormField<bool>(
                              initialValue: _isChecked,
                              validator: (value) {
                                if (value == null || !value) {
                                  return "Please accept the SkillGrid Terms of Service before continuing";
                                }
                                return null;
                              },
                              builder: (FormFieldState<bool> state) {
                                return Row(children: [
                                  Checkbox(
                                    value: state.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                      state.didChange(value);
                                    },
                                    side: BorderSide(
                                      color: state.hasError
                                          ? Colors.red
                                          : const Color(0xFF625D5D),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 289,
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          color: Color(0xFF625D5D),
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Yes, I understand and agree to the ',
                                          ),
                                          TextSpan(
                                            text: 'SkillGrid Terms of Service',
                                            style: TextStyle(
                                              color: Color(0xFF322E86),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ', including the User Agreement and ',
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: Color(
                                                  0xFF322E86), // Purple color
                                              decoration: TextDecoration
                                                  .underline, // Underline decoration
                                            ),
                                          ),
                                          TextSpan(
                                            text: '.',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          width: 295,
                          height: 43,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<FreelancerBloc>().add(
                                    RegisterFreelancer(
                                        context: context,
                                        firstName: _fnameController.text.trim(),
                                        lastName: _lnameController.text.trim(),
                                        dateOfBirth: selectedDate!,
                                        mobileNo:
                                            _mobNumberController.text.trim(),
                                        address: _addressController.text.trim(),
                                        city: city!,
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        available: true));
                              }
                            },
                            child: BlocBuilder<FreelancerBloc, FreelancerState>(
                                builder: (context, state) {
                              if (state.isLoading) {
                                return const CircularProgressIndicator(
                                  color: Color(0XFF322E86),
                                );
                              }
                              return const Text("Create my account");
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 70, left: 35, top: 20),
                          child: Row(
                            children: [
                              const Text("Already have an account?",
                                  style: TextStyle(
                                    color: Color(0xFF322E86),
                                    fontSize: 16,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<FreelancerBloc>().add(
                                      NavigateToLoginScreen(
                                          context: context,
                                          destination:
                                              const LoginScreenView()));
                                },
                                child: const Text("Log in",
                                    style: TextStyle(
                                        color: Color(0xFF544FBD),
                                        fontSize: 16,
                                        fontFamily: "Caprasimo")),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
