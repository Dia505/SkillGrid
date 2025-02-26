import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_state_management/theme_bloc.dart';

class CommonDropdown<T> extends StatefulWidget {
  const CommonDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.width = double.infinity,
      this.hintText,
      this.value});

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged; // Callback to notify parent widget
  final double width;
  final String? hintText;
  final T? value;

  @override
  State<CommonDropdown<T>> createState() => _CommonDropdownState<T>();
}

class _CommonDropdownState<T> extends State<CommonDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value; // Initialize with the passed value
  }

  @override
  void didUpdateWidget(covariant CommonDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        selectedValue =
            widget.value; // ✅ Ensure state updates when value changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color dropDownBorderColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF322E86);
        return SizedBox(
          width: widget.width,
          child: DropdownButtonFormField<T>(
            value: selectedValue,
            items: widget
                .items, // Pass the items directly as they are already DropdownMenuItem
            onChanged: (T? value) {
              setState(() {
                selectedValue = value; // ✅ Update local state
              });
              widget.onChanged(value); // ✅ Notify parent widget
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a value'; // Show error message if nothing is selected
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(color: dropDownBorderColour, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(color: dropDownBorderColour, width: 2),
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
      },
    );
  }
}
