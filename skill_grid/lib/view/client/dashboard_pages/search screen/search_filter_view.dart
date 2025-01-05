import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';

class SearchFilterView extends StatefulWidget {
  const SearchFilterView({super.key});

  @override
  State<SearchFilterView> createState() => _SearchFilterViewState();
}

class _SearchFilterViewState extends State<SearchFilterView> {
  final cityList = [
    const DropdownMenuItem(value: "Kathmandu", child: Text("Kathmandu")),
    const DropdownMenuItem(value: "Lalitpur", child: Text("Lalitpur")),
    const DropdownMenuItem(value: "Bhaktapur", child: Text("Bhaktapur")),
    const DropdownMenuItem(value: "Pokhara", child: Text("Pokhara")),
    const DropdownMenuItem(value: "Chitwan", child: Text("Chitwan")),
    const DropdownMenuItem(value: "Lumbini", child: Text("Lumbini")),
    const DropdownMenuItem(value: "Janakpur", child: Text("Janakpur")),
    const DropdownMenuItem(value: "Biratnagar", child: Text("Biratnagar")),
    const DropdownMenuItem(value: "Dharan", child: Text("Dharan")),
    const DropdownMenuItem(value: "Butwal", child: Text("Butwal")),
  ];

  String? city;

  final List<bool> _selectedHourlyRate = [
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final hourlyRateRange = [
    "< Rs. 1000",
    "Rs. 1000 - Rs. 2000",
    "Rs. 2000 - Rs. 3000",
    "Rs. 3000 - Rs. 4000",
    "Rs. 4000 - Rs. 5000",
    "> Rs. 5000"
  ];

  double _selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Ensures the sheet only takes up necessary space
        children: [
          const Text(
            "Filters",
            style: TextStyle(fontSize: 28, fontFamily: "Caprasimo"),
          ),
          const SizedBox(
            height: 16,
          ),
          CommonDropdown(
            width: 325,
            hintText: "Location",
            items: cityList,
            onChanged: (value) {
              if (value != null) {
                city = value;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Hourly rate",
            style: TextStyle(fontFamily: "Inter Medium"),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            children: hourlyRateRange.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return FilterChip(
                label: Text(
                  option,
                  style: const TextStyle(fontFamily: "Inter Medium"),
                ),
                selected: _selectedHourlyRate[index],
                selectedColor: const Color(0xFFCCCAFF),
                backgroundColor: Colors.white,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedHourlyRate[index] = selected;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Rating",
            style: TextStyle(fontFamily: "Inter Medium"),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color:
                    index < _selectedRating.ceil() ? Colors.amber : Colors.grey,
                size: 36,
              );
            }),
          ),
          const SizedBox(height: 16),
          // Slider
          Slider(
            value: _selectedRating,
            min: 0.0,
            max: 5.0,
            divisions: 5,
            label: _selectedRating.toStringAsFixed(0),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey.shade300,
            onChanged: (value) {
              setState(() {
                _selectedRating = value;
              });
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the filter page
                },
                child: const Text("Apply"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
