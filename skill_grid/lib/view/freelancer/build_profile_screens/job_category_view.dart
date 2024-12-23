import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/job_category_card.dart';

class JobCategoryView extends StatefulWidget {
  const JobCategoryView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<JobCategoryView> createState() => _JobCategoryViewState();
}

class _JobCategoryViewState extends State<JobCategoryView> {
  final List<Map<String, dynamic>> jobCategories = [
    {"icon": Icons.computer_rounded, "label": "Technology"},
    {"icon": Icons.design_services, "label": "Design"},
    {"icon": Icons.ads_click, "label": "Marketing"},
    {"icon": Icons.bar_chart, "label": "Business"},
    {"icon": Icons.school, "label": "Education"},
    {"icon": Icons.camera_alt_outlined, "label": "Photography"},
    {"icon": Icons.palette_outlined, "label": "Artisan and Craft"},
    {"icon": Icons.create_outlined, "label": "Content Creation"},
  ];

  String? selectedCategory;

  void _onCategorySelected(String label) {
    setState(() {
      selectedCategory = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        children: [
          const Text(
            "Select your job category",
            style: TextStyle(
              color: Color(0xFF322E86),
              fontSize: 20,
              fontFamily: "Inter Medium",
            ),
          ),

          const SizedBox(height: 20,),
          
          Form(
            key: widget.formKey,
            child: FormField<String>(
              validator: (value) {
                if (selectedCategory == null) {
                  return 'Please select a job category.';
                }
                return null;
              },
              builder: (state) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: jobCategories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            final category = jobCategories[index];
                            return JobCategoryCard(
                              icon: category["icon"],
                              label: category["label"],
                              isSelected: selectedCategory == category["label"],
                              onSelect: _onCategorySelected,
                            );
                          },
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Color.fromARGB(255, 255, 17, 0), fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
