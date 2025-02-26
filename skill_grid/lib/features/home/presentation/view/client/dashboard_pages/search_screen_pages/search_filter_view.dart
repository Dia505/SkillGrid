import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/theme/theme_state_management/theme_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';

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

  final List<bool> _selectedHourlyRate = [
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final hourlyRateRanges = {
    "< Rs. 1000": (0, 999),
    "Rs. 1000 - Rs. 2000": (1000, 2000),
    "Rs. 2000 - Rs. 3000": (2000, 3000),
    "Rs. 3000 - Rs. 4000": (3000, 4000),
    "Rs. 4000 - Rs. 5000": (4000, 5000),
    "> Rs. 5000": (5001, 100000),
  };

  String? selectedCity;
  final Set<String> selectedHourlyRates = {};
  double selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color filterContainerBgColour =
            themeState.isDarkMode ? Colors.black : Colors.white;
        Color hourlyRateFilterColour =
            themeState.isDarkMode ? Colors.grey : Colors.white;
        return Container(
          width: double.infinity,
          color: filterContainerBgColour,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize
                .min, // Ensures the sheet only takes up necessary space
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
                    setState(() {
                      selectedCity = value;
                    });
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
                children: hourlyRateRanges.keys.map((option) {
                  return FilterChip(
                    label: Text(option,
                        style: const TextStyle(fontFamily: "Inter Medium")),
                    selected: selectedHourlyRates.contains(option),
                    selectedColor: const Color(0xFFCCCAFF),
                    backgroundColor: hourlyRateFilterColour,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedHourlyRates.add(option);
                        } else {
                          selectedHourlyRates.remove(option);
                        }
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
                    color: index < selectedRating.ceil()
                        ? Colors.amber
                        : Colors.grey,
                    size: 36,
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Slider
              Slider(
                value: selectedRating,
                min: 0,
                max: 5,
                divisions: 5,
                label: selectedRating.toStringAsFixed(0),
                activeColor: Colors.amber,
                inactiveColor: Colors.grey.shade300,
                onChanged: (value) {
                  setState(() {
                    selectedRating = value;
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
                      context.read<SearchBloc>().add(FilterByCriteria(
                          selectedCity,
                          selectedHourlyRates.toList(),
                          selectedRating.toInt()));
                      Navigator.pop(context); // Close the filter page
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
