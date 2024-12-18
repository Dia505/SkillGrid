import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/common/common_textfield.dart';

class JobDetailsView extends StatefulWidget {
  const JobDetailsView({
    super.key,
    required this.formKey
  });

  final GlobalKey<FormState> formKey;

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  final TextEditingController _professionTitleController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  int? experienceYears;
  late List<int> experienceYearsList;

  @override
  void initState() {
    super.initState();
    experienceYearsList = List.generate(50, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Describe your job",
          style: GoogleFonts.inter(
            color: const Color(0xFF322E86),
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),),
    
          const SizedBox(height: 10,),
    
          Text("Share the details of your work, skills, and what clients can expect.",
          style: GoogleFonts.inter(
            color: const Color(0xFF322E86),
            fontSize: 15
          ),),
    
          const SizedBox(height: 25),
    
          Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextfield(
                  textFieldTitle: "Title of your profession", 
                  controller: _professionTitleController, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*required';
                    }
                        
                    return null;
                  },
                ),
    
                CommonTextfield(
                  textFieldTitle: "Skills", 
                  controller: _skillsController, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*required';
                    }
                        
                    return null;
                  },
                  hintText: "Add relevant skills to highlight your expertise",
                ),
    
                const SizedBox(height: 10,),
    
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 8),
                  child: Text("Years of experience",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF322E86)
                  ),),
                ),
    
                CommonDropdown(
                  width: 170,
                  items: experienceYearsList
                    .map((date) => DropdownMenuItem<int>(
                      value: date,
                      child: Text(date.toString()),
                    ))
                    .toList(),
                                
                  onChanged: (value) {
                    if (value != null) {
                      experienceYears = value;
                    }
                  },
                )
              ],
            )
          )
        ],
      ),
    );
  }
}