import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_textfield.dart';

class ServicesFormView extends StatefulWidget {
  const ServicesFormView({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<ServicesFormView> createState() => _ServicesFormViewState();
}

class _ServicesFormViewState extends State<ServicesFormView> {
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  
  // List to hold multiple forms dynamically
  List<Widget> _formWidgets = [];

  // Method to add a new form
  void _addForm() {
    setState(() {
      _formWidgets.add(
        Form(
          key: GlobalKey<FormState>(),  // New unique key for each form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextfield(
                textFieldTitle: "Service name", 
                controller: TextEditingController(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*required';
                  }
                  return null;
                },
              ),
              CommonTextfield(
                width: 250,
                textFieldTitle: "Hourly rate", 
                controller: TextEditingController(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*required';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 18.0, bottom: 20.0),
                child: CommonButton(
                  buttonText: "🖼️ Upload photo", 
                  onPressed: () {},
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Highlight your services",
              style: TextStyle(
                  color: Color(0xFF322E86),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text(
              "Specify the services you specialize in to attract the right clients",
              style: TextStyle(color: Color(0xFF322E86), fontSize: 15),
            ),
            const SizedBox(height: 25),
      
            // Initial Form to be displayed
            Form(
              key: widget.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextfield(
                    textFieldTitle: "Service name", 
                    controller: _serviceController, 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*required';
                      }
                      return null;
                    },
                  ),
                  CommonTextfield(
                    width: 250,
                    textFieldTitle: "Hourly rate", 
                    controller: _rateController, 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 18.0, bottom: 20.0),
                    child: CommonButton(
                      buttonText: "🖼️ Upload photo", 
                      onPressed: () {},
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            
            // Display dynamically added forms
            ..._formWidgets,
      
            // Add new form button, always at the bottom
            Center(
              child: ElevatedButton(
                onPressed: _addForm,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: const Color(0xFFE7E7FF),
                  side: const BorderSide(
                    color: Color(0xFF322E86),
                    width: 2,
                  ),
                ),
                child: const Icon(Icons.add, color: Color(0xFF322E86)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
