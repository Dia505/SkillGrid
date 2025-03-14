import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/common/common_textfield.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_view.dart';
import 'package:skill_grid/features/profile/presentation/view_model/edit_profile/client_edit_profile_bloc.dart';

class ClientProfileEditView extends StatefulWidget {
  const ClientProfileEditView({super.key});

  @override
  State<ClientProfileEditView> createState() => _ClientProfileEditViewState();
}

class _ClientProfileEditViewState extends State<ClientProfileEditView> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController mobNumberController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? selectedCity;
  File? _img;

  @override
  void initState() {
    super.initState();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    mobNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    context.read<ClientEditProfileBloc>().loadClient();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    mobNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(
      ImageSource imageSource, ClientEntity client) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });

        // Ensure clientId is not null before dispatching the event
        if (client.clientId != null && mounted) {
          final clientBloc = context.read<ClientEditProfileBloc>();
          if (mounted) {
            clientBloc.add(UpdateProfilePicture(
                file: _img!, clientId: client.clientId!, context: context));
          }
        } else {
          debugPrint("Error: client.clientId is null");
        }
      }
    } catch (e) {
      debugPrint("Exception thrown: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final cityList = [
      'Kathmandu',
      'Lalitpur',
      'Bhaktapur',
      'Pokhara',
      'Chitwan',
      'Lumbini',
      'Janakpur',
      'Biratnagar',
      'Dharan',
      'Butwal'
    ].map((city) => DropdownMenuItem(value: city, child: Text(city))).toList();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color cityDropDownTitleColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF322E86);
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                context.read<ClientEditProfileBloc>().add(
                    NavigateToClientProfile(
                        context: context,
                        destination: const ClientProfileView()));
              },
            ),
          ),
          body: BlocBuilder<ClientEditProfileBloc, ClientEditProfileState>(
              builder: (context, state) {
            if (state is ClientEditProfileLoaded) {
              final client = state.clientEntity;
              fnameController.text = client.firstName;
              lnameController.text = client.lastName;
              mobNumberController.text = client.mobileNo;
              emailController.text = client.email;
              selectedCity = client.city;

              return SingleChildScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            checkCameraPermission();
                                            _browseImage(
                                                ImageSource.camera, client);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.camera,
                                              color: Colors.white),
                                          label: const Text('Camera'),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            checkCameraPermission();
                                            _browseImage(
                                                ImageSource.gallery, client);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.image,
                                              color: Colors.white),
                                          label: const Text('Gallery'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : client.profilePicture != null
                                        ? NetworkImage(client.profilePicture!
                                            .replaceFirst(
                                                'localhost', '10.0.2.2'))
                                        : const AssetImage(
                                                "assets/images/default_profile_img.png")
                                            as ImageProvider,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 45.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextfield(
                                      textFieldTitle: "First name",
                                      controller: fnameController),
                                  CommonTextfield(
                                      textFieldTitle: "Last name",
                                      controller: lnameController),
                                  CommonTextfield(
                                      textFieldTitle: "Mobile number",
                                      controller: mobNumberController),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text("City",
                                        style: TextStyle(
                                            color: cityDropDownTitleColour,
                                            fontSize: 15)),
                                  ),
                                  const SizedBox(height: 7),
                                  CommonDropdown(
                                    width: 325,
                                    items: cityList,
                                    value: selectedCity,
                                    onChanged: (value) {
                                      if (value != null) {
                                        selectedCity = value;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 7),
                                  CommonTextfield(
                                      textFieldTitle: "Email address",
                                      controller: emailController),
                                  CommonTextfield(
                                      textFieldTitle: "Password",
                                      controller: passwordController,
                                      obscureText: true),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final clientBloc =
                                      context.read<ClientEditProfileBloc>();

                                  // First, check if the profile picture needs updating
                                  if (_img != null) {
                                    clientBloc.add(UpdateProfilePicture(
                                      file: _img!,
                                      clientId: client.clientId!,
                                      context: context,
                                    ));
                                  }

                                  // Dispatch UpdateClient event for bio updates
                                  clientBloc.add(UpdateClient(
                                    clientId: client.clientId!,
                                    firstName: fnameController.text.isNotEmpty
                                        ? fnameController.text
                                        : null,
                                    lastName: lnameController.text.isNotEmpty
                                        ? lnameController.text
                                        : null,
                                    mobileNo:
                                        mobNumberController.text.isNotEmpty
                                            ? mobNumberController.text
                                            : null,
                                    city: selectedCity,
                                    email: emailController.text.isNotEmpty
                                        ? emailController.text
                                        : null,
                                    password: passwordController.text.isNotEmpty
                                        ? passwordController.text
                                        : null,
                                    context: context,
                                  ));
                                }
                              },
                              child: const Text("Save"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        );
      },
    );
  }
}
