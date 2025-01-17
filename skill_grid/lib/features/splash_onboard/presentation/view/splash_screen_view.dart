import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/splash_screen/splash_screen_cubit.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashScreenCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Container(
          width: double.infinity,
          color: const Color(0xFF322E86),

          child: Padding(
            padding: const EdgeInsets.only(bottom: 55),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash_screen_logo.png",
                  width: 151,
                  height: 154,),
                    
                const Text(
                  "SkillGrid.", 
                  style:TextStyle(
                    color: Color(0xFFE7E7FF),
                    fontSize: 40,
                    fontFamily: "Caprasimo"
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}