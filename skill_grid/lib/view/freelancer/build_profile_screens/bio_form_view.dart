import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_textfield.dart';

class BioFormView extends StatefulWidget {
  const BioFormView({
    super.key,
    required this.formKey
  });

  final GlobalKey<FormState> formKey;

  @override
  State<BioFormView> createState() => _BioFormViewState();
}

class _BioFormViewState extends State<BioFormView> {
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text("Great! Now write a bio about yourself ",
          style: TextStyle(
            color: Color(0xFF322E86),
            fontSize: 20,
            fontFamily: "Inter Medium"
          ),),
    
          const SizedBox(height: 10,),
    
          const Text("Help potential clients get to know you at a glance. Share your expertise, experience, and what sets you apart.",
          style: TextStyle(
            color: Color(0xFF322E86),
            fontSize: 15
          ),),

          Form(
            key: widget.formKey,
            child: CommonTextfield(
              textFieldTitle: "Bio", 
              controller: _bioController, 
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*required';
                }
                        
                return null;
              },
            )
          )
        ],
      ),
    );
  }
}