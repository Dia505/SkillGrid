import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextfield extends StatefulWidget {
  const CommonTextfield({
    super.key, 
    required this.textFieldTitle, 
    this.obscureText = false,
    required this.controller,
    required this.validator,
    this.width,
  });

  final String textFieldTitle;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? width;

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
              width: widget.width,
              padding: const EdgeInsets.only(right: 40),
              
              child: TextFormField(
                obscureText: widget.obscureText,
                controller: widget.controller,
                validator: widget.validator,

                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Color(0xFF322E86), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Color(0xFF322E86), width: 2)),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                      borderSide:
                        const BorderSide(color: Colors.red, width: 1)),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                      borderSide:
                        const BorderSide(color: Colors.red, width: 2))
                ),
            ))
        ],
      ),
    );
  }
}
