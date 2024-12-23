import 'package:flutter/material.dart';

class JobCategoryView extends StatefulWidget {
  const JobCategoryView({super.key});

  @override
  State<JobCategoryView> createState() => _JobCategoryViewState();
}

class _JobCategoryViewState extends State<JobCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Text("Job Category"),
      ),
    );
  }
}