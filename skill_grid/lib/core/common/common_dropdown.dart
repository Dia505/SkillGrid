import 'package:flutter/material.dart';

class CommonDropdown<T> extends StatefulWidget {
  const CommonDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.width = double.infinity,
    this.hintText
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged; // Callback to notify parent widget
  final double width;
  final String? hintText;

  @override
  State<CommonDropdown<T>> createState() => _CommonDropdownState<T>();
}

class _CommonDropdownState<T> extends State<CommonDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = null; // Ensure no initial value is selected
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      
      child: DropdownButtonFormField<T>(
        value: selectedValue, // This will be null by default
        items: widget.items, // Pass the items directly as they are already DropdownMenuItem
        onChanged: (T? value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged(value); // Notify parent of the change
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a value'; // Show error message if nothing is selected
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFF322E86), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFF322E86), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),

        hint: widget.hintText != null
            ? Text(widget.hintText!) // Display hint text if provided
            : null,
      ),
    );
  }
}
