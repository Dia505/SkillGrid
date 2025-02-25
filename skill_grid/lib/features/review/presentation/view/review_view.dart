import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/review/presentation/view_model/review_bloc.dart';

class ReviewView extends StatefulWidget {
  final String freelancerProfileImgPath;
  final String freelancerFirstName;
  final String freelancerLastName;
  final String profession;
  final String appointmentPurpose;
  final FreelancerEntity freelancer;
  final AppointmentEntity appointment;

  const ReviewView(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerFirstName,
      required this.freelancerLastName,
      required this.profession,
      required this.appointmentPurpose,
      required this.freelancer,
      required this.appointment});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewBloc>().add(FetchClientData());
  }

  final _formKey = GlobalKey<FormState>();
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(builder: (context, event) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Review",
                style: TextStyle(
                    color: Color(0xFFE7E7FF),
                    fontSize: 24,
                    fontFamily: "Caprasimo")),
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color(0xFF322E86),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                context.read<ReviewBloc>().add(NavigateToContracts(
                    context: context, destination: const ClientDashboard()));
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                                "http://10.0.2.2:3000/freelancer_images/${widget.freelancerProfileImgPath}")
                            as ImageProvider,
                        radius: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.freelancerFirstName} ${widget.freelancerLastName}",
                              style: const TextStyle(
                                fontFamily: "Inter Bold",
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              widget.profession,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                        children: [
                          const TextSpan(text: "Project: "),
                          TextSpan(
                              text: widget.appointmentPurpose,
                              style: const TextStyle(
                                  fontFamily: "Inter Regular",
                                  color: Colors.black))
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rating:",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFF322E86),
                            fontFamily: "Inter Bold"),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: index < _selectedRating
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 35,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedRating = index + 1; // Update rating
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 7,
                    controller: _reviewController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*required';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Share your thoughts.....",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButton(
                      buttonText: "Send",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final state = context.read<ReviewBloc>().state;
                          if (state is ClientFetched) {
                            context.read<ReviewBloc>().add(SaveReview(
                                context: context,
                                review: _reviewController.text.trim(),
                                rating: _selectedRating,
                                reviewDate: DateTime.now(),
                                client: state.client,
                                freelancer: widget.freelancer,
                                appointment: widget.appointment));
                          }
                        }
                      })
                ],
              ),
            ),
          ));
    });
  }
}
