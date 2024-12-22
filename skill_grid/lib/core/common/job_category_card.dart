import 'package:flutter/material.dart';

class JobCategoryCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function(String) onSelect;

  const JobCategoryCard({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onSelect,
  });

  @override
  State<JobCategoryCard> createState() => _JobCategoryCardState();
}

class _JobCategoryCardState extends State<JobCategoryCard> {
  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isSelected
        ? const Color(0xFF322E86)
        : const Color.fromARGB(255, 171, 170, 170);

    final iconColor = widget.isSelected ? const Color(0xFF322E86) : const Color(0xFF676767);

    final fontWeight = widget.isSelected ? FontWeight.bold : FontWeight.w500;

    return GestureDetector(
      onTap: () {
        widget.onSelect(widget.label); // Notify parent about selection
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Card(
          color: const Color(0XFFE7E7FF),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  size: 70,
                  color: iconColor,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: fontWeight,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
