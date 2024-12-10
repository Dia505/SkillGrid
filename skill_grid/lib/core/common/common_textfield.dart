import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextfield extends StatefulWidget {
  const CommonTextfield(
      {super.key, required this.textFieldTitle, this.obscureText = false});

  final String textFieldTitle;
  final bool obscureText;

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(widget.textFieldTitle,
                style: GoogleFonts.inter(
                    color: const Color(0xFF322E86), fontSize: 15)),
          ),
      
          const SizedBox(height: 7),
      
          Container(
              padding: const EdgeInsets.only(right: 40),
              child: TextFormField(
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Color(0xFF322E86), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Color(0xFF322E86), width: 2)),
                ),
            ))
        ],
      ),
    );
  }
}
