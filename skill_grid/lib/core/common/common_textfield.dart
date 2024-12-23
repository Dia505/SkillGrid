import 'package:flutter/material.dart';

class CommonTextfield extends StatefulWidget {
  const CommonTextfield({
    super.key, 
    required this.textFieldTitle, 
    this.obscureText = false,
    required this.controller,
    required this.validator,
    this.width,
    this.hintText 
  });

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(widget.textFieldTitle,
                style: const TextStyle(
                    color: Color(0xFF322E86), fontSize: 16)),
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
  }
}
