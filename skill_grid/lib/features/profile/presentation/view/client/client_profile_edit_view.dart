import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/common/common_textfield.dart';

class ClientProfileEditView extends StatelessWidget {
  const ClientProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fnameController = TextEditingController();
    final TextEditingController lnameController = TextEditingController();
    final TextEditingController mobNumberController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    fnameController.text = "firstName";
    lnameController.text = "lastName";
    mobNumberController.text = "mobileNo";
    emailController.text = "email";
    passwordController.text = "password";

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

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile",
              style: TextStyle(
                  color: Color(0xFFE7E7FF),
                  fontSize: 24,
                  fontFamily: "Caprasimo")),
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFF322E86),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SafeArea(
                child: Align(
              alignment: Alignment.topCenter,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: const Color(0xFF544FBD),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage("assets/images/client_profile_img.jpg"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextfield(
                            textFieldTitle: "First name",
                            controller: fnameController,
                          ),
                          CommonTextfield(
                            textFieldTitle: "Last name",
                            controller: lnameController,
                          ),
                          CommonTextfield(
                            textFieldTitle: "Mobile number",
                            controller: mobNumberController,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            child: const Text("City",
                                style: TextStyle(
                                    color: Color(0xFF322E86), fontSize: 15)),
                          ),
                          const SizedBox(height: 7),
                          CommonDropdown(
                            width: 325,
                            items: cityList,
                            onChanged: (value) {
                              if (value != null) {
                                city = value;
                              }
                            },
                          ),
                          const SizedBox(height: 7),
                          CommonTextfield(
                            textFieldTitle: "Email address",
                            controller: emailController,
                          ),
                          CommonTextfield(
                            textFieldTitle: "Password",
                            controller: passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("Save")),
                  ],
                ),
              ),
            )),
          ),
        ));
  }
}
