import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';

class CommonTextfield extends StatefulWidget {
  const CommonTextfield(
      {super.key,
      required this.textFieldTitle,
      this.obscureText = false,
      required this.controller,
      this.validator,
      this.width,
      this.hintText});

  final String textFieldTitle;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? width;
  final String? hintText;

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textFieldTitleColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF322E86);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12),
                child: Text(widget.textFieldTitle,
                    style:
                        TextStyle(color: textFieldTitleColour, fontSize: 18)),
              ),
              const SizedBox(height: 7),
              Container(
                  width: widget.width,
                  padding: const EdgeInsets.only(right: 40),
                  child: TextFormField(
                    obscureText: widget.obscureText,
                    controller: widget.controller,
                    validator: widget.validator,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
