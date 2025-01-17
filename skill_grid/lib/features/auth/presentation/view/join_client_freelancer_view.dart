import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_logo.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_state.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';

class JoinClientFreelancerView extends StatelessWidget {
  const JoinClientFreelancerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => JoinAsClientFreelancerCubit(
          clientBloc: context.read<ClientBloc>(),
          freelancerBloc: context.read<FreelancerBloc>(),
          loginBloc: context.read<LoginBloc>(),
        ),
        child: BlocBuilder<JoinAsClientFreelancerCubit,
            JoinAsClientFreelancerState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              color: const Color(0xFF322E86),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonLogo(),
                  const Text(
                    "Join as a client or freelancer",
                    style: TextStyle(
                        color: Color(0xFFE7E7FF),
                        fontSize: 20,
                        fontFamily: "Caprasimo"),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<JoinAsClientFreelancerCubit>()
                        .selectClient(),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: state.selectedRole == UserRole.client
                              ? const Color(0xFFE7E7FF)
                              : const Color(0xFF929292),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      width: 330,
                      height: 160,
                      child: Card(
                        color: const Color(0xFF322E86),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/join_as_client.png",
                                width: 95, height: 135),
                            const SizedBox(
                              width: 170,
                              child: Text(
                                "I’m a client, hiring for a project",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Inter SemiBold"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 95),
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: state.selectedRole == UserRole.client
                                        ? const Color(0xFFE7E7FF)
                                        : const Color(0xFF929292),
                                    width: 2.0,
                                  ),
                                  color: state.selectedRole == UserRole.client
                                      ? const Color(0xFFE7E7FF)
                                      : const Color(0xFF322E86),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<JoinAsClientFreelancerCubit>()
                        .selectFreelancer(),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: state.selectedRole == UserRole.freelancer
                              ? const Color(0xFFE7E7FF)
                              : const Color(0xFF929292),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      width: 330,
                      height: 160,
                      child: Card(
                        color: const Color(0xFF322E86),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          children: [
                            Image.asset("assets/images/join_as_freelancer.png",
                                width: 140, height: 125),
                            const SizedBox(
                              width: 151,
                              child: Text(
                                "I’m a freelancer, looking for work",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Inter SemiBold"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 95),
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: state.selectedRole ==
                                            UserRole.freelancer
                                        ? const Color(0xFFE7E7FF)
                                        : const Color(0xFF929292),
                                    width: 2.0,
                                  ),
                                  color:
                                      state.selectedRole == UserRole.freelancer
                                          ? const Color(0xFFE7E7FF)
                                          : const Color(0xFF322E86),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CommonButton(
                    buttonText: state.selectedRole == UserRole.client
                        ? "Join as Client"
                        : state.selectedRole == UserRole.freelancer
                            ? "Apply as Freelancer"
                            : "Create Account",
                    buttonColor: state.selectedRole != null
                        ? const Color(0xFFE7E7FF)
                        : const Color(0xFF929292),
                    buttonTextColor: state.selectedRole != null
                        ? const Color(0xFF322E86)
                        : const Color(0xFFD3CDCD),
                    onPressed: () => context
                        .read<JoinAsClientFreelancerCubit>()
                        .navigateBasedOnRole(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70, left: 75),
                    child: Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Color(0xFFE7E7FF),
                              fontSize: 16,
                              fontFamily: "Inter Medium"),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => context
                              .read<JoinAsClientFreelancerCubit>()
                              .navigateToLoginScreen(context),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Color(0xFFE7E7FF),
                                fontSize: 16,
                                fontFamily: "Caprasimo"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
