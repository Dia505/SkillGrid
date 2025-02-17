import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_edit_view.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';

class ClientProfileView extends StatefulWidget {
  const ClientProfileView({super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ClientProfileBloc>().loadClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFFE7E7FF),
            fontSize: 24,
            fontFamily: "Caprasimo",
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF322E86),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.read<ClientProfileBloc>().add(NavigateToClientDashboard(
                context: context, destination: const ClientDashboard()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: BlocBuilder<ClientProfileBloc, ClientProfileState>(
              builder: (context, state) {
                if (state is ClientProfileLoaded) {
                  final client = state.clientEntity;
                  String imageUrl = client.profilePicture ?? '';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(
                                imageUrl.replaceFirst('localhost', '10.0.2.2'))
                            : const AssetImage(
                                    "assets/images/default_profile_img.png")
                                as ImageProvider,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ClientProfileBloc>().add(
                                NavigateToEditClientProfile(
                                  context: context,
                                  destination: const ClientProfileEditView()
                                ),
                              );
                        },
                        child: const Text("Edit profile"),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileField(
                              "Name", "${client.firstName} ${client.lastName}"),
                          _buildProfileField("Phone", client.mobileNo),
                          _buildProfileField("City", client.city),
                          _buildProfileField("Email", client.email),
                        ],
                      ),
                    ],
                  );
                } else if (state is ClientProfileLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ClientProfileError) {
                  return Text("Error: ${state.message}");
                }
                return const CircularProgressIndicator(); // Fallback loading state
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 19, fontFamily: "Inter Bold"),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
