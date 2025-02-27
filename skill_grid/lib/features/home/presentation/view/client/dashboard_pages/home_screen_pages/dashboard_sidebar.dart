import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_view.dart';

class DashboardSidebar extends StatefulWidget {
  const DashboardSidebar({super.key});

  @override
  State<DashboardSidebar> createState() => _DashboardSidebarState();
}

class _DashboardSidebarState extends State<DashboardSidebar> {
  @override
  void initState() {
    super.initState();
    context.read<ClientSidebarBloc>().loadClient();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color sidebarBackgroundColor =
            themeState.isDarkMode ? Colors.black : Colors.white;
        Color logOutButtonColor = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF322E86);
        return Container(
          width: 317,
          color: sidebarBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            children: [
              Row(
                children: [
                  BlocBuilder<ClientSidebarBloc, ClientSidebarState>(
                    builder: (context, state) {
                      if (state is ClientSidebarLoaded) {
                        final client = state.clientEntity;
                        String imageUrl = client.profilePicture ?? '';

                        return CircleAvatar(
                            radius: 30,
                            backgroundImage: client.profilePicture != null
                                ? NetworkImage(imageUrl.replaceFirst(
                                    'localhost', '10.0.2.2'))
                                : const AssetImage(
                                    "assets/images/default_profile_img.png"));
                      } else {
                        return const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              "assets/images/default_profile_img.png"),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ClientSidebarBloc, ClientSidebarState>(
                        builder: (context, state) {
                          if (state is ClientSidebarLoaded) {
                            final client = state.clientEntity;

                            return Text(
                              "${client.firstName} ${client.lastName}",
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: "Inter Bold"),
                            );
                          } else {
                            return const Text(
                              "Client",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Inter Bold"),
                            );
                          }
                        },
                      ),
                      const Text(
                        "Client",
                        style:
                            TextStyle(color: Color(0xFF707070), fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ClientSidebarBloc>().add(
                          NavigateToClientProfile(
                              context: context,
                              destination: const ClientProfileView()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person_outline_sharp,
                          size: 28,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "Inter SemiBold"),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return SwitchListTile(
                    title: const Text("Dark Mode"),
                    value: state.isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleTheme());
                    },
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: GestureDetector(
                  onTap: () {
                    context.read<ClientSidebarBloc>().add(LogOutEvent(
                        context: context,
                        destination: const LoginScreenView()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 28, color: logOutButtonColor),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Inter SemiBold",
                            color: logOutButtonColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
