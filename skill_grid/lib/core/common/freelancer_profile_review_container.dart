import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_state_management/theme_bloc.dart';

class FreelancerProfileReviewContainer extends StatelessWidget {
  final String projectTitle;
  final String rating;
  final String reviewDate;
  final String? review;

  const FreelancerProfileReviewContainer(
      {super.key,
      required this.projectTitle,
      required this.rating,
      required this.reviewDate,
      this.review});

  @override
  Widget build(BuildContext context) {
    int ratingValue = int.tryParse(rating) ?? 0;
    String stars = '⭐' * ratingValue;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color reviewProjectColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0XFF544FBD);
        return SizedBox(
          width: 332,
          height: review != null && review!.isNotEmpty ? 92 : 55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectTitle,
                style: TextStyle(color: reviewProjectColour, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    stars,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text("|"),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    reviewDate,
                    style: const TextStyle(color: Color(0XFF707070), fontSize: 13),
                  )
                ],
              ),
              if (review != null && review!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  review!,
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
