import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/appointment_freelancer_card.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/send_an_offer/send_an_offer_bloc.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/profile/presentation/view/freelancer_profile_view.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

class SendOfferView extends StatefulWidget {
  final String freelancerId;
  const SendOfferView({super.key, required this.freelancerId});

  @override
  State<SendOfferView> createState() => _SendOfferViewState();
}

class _SendOfferViewState extends State<SendOfferView> {
  String? selectedService;
  int? hourlyRate;
  DateTime? selectedDate;
  String? duration;
  TimeOfDay? selectedTime;
  String? selectedFreelancerServiceId;
  String? selectedServiceId;

  void _showDatePicker() {
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now().add(const Duration(days: 365));

    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  final durationList = [
    const DropdownMenuItem(value: "hour", child: Text("hour")),
    const DropdownMenuItem(value: "day", child: Text("day")),
    const DropdownMenuItem(value: "week", child: Text("week")),
    const DropdownMenuItem(value: "month", child: Text("month")),
    const DropdownMenuItem(value: "year", child: Text("year"))
  ];

  void _showTimePicker() {
    showTimePicker(
            context: context, initialTime: selectedTime ?? TimeOfDay.now())
        .then((value) {
      setState(() {
        selectedTime = value;
      });
    });
  }

  String? formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return null;
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  bool _isChecked = false;

  final TextEditingController _appointmentPurposeController =
      TextEditingController();
  final TextEditingController _projectDurationValueController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SendAnOfferBloc>(context)
          .add(FetchFreelancerDetailsEvent(freelancerId: widget.freelancerId));
    });

    String? appointmentTimeString = formatTimeOfDay(selectedTime);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textfieldColour =
            themeState.isDarkMode ? Colors.white : Colors.black;
        Color termsColour = themeState.isDarkMode
            ? const Color(0xFFE7E7FF)
            : const Color(0xFF322E86);

        return BlocBuilder<SendAnOfferBloc, SendAnOfferState>(
          builder: (context, state) {
            if (state is FreelancerProfileLoaded) {
              final freelancer = state.freelancerEntity;
              final services = state.services;
              final client = state.clientEntity;

              final serviceList = services
                  .map((service) => DropdownMenuItem<String>(
                        value: service.service.serviceName,
                        child: Text(service.service.serviceName),
                      ))
                  .toList();

              late AppointmentEntity appointmentEntity = AppointmentEntity(
                appointmentPurpose: _appointmentPurposeController.text,
                appointmentDate: selectedDate ?? DateTime.now(),
                projectDuration: ProjectDuration(
                  value:
                      int.tryParse(_projectDurationValueController.text) ?? 0,
                  unit: duration ?? 'hour',
                ),
                status: false,
                appointmentTime: appointmentTimeString,
                freelancerService: FreelancerServiceEntity(
                    freelancerServiceId: selectedFreelancerServiceId,
                    hourlyRate: hourlyRate!,
                    service: ServiceEntity(
                        serviceId: selectedServiceId,
                        serviceName: selectedService!),
                    freelancer: freelancer),
                client: client,
              );

              return Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 15, right: 15, bottom: 40),
                      child: Column(
                        children: [
                          const Text(
                            "Send an Offer",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "Inter SemiBold"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppointmentFreelancerCard(
                            freelancerProfileImgPath:
                                freelancer.profilePicture!,
                            freelancerName:
                                "${freelancer.firstName} ${freelancer.lastName}",
                            profession: freelancer.profession!,
                            address: freelancer.address,
                            city: freelancer.city,
                            mobileNo: freelancer.mobileNo,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: textfieldColour,
                                        fontFamily: "Inter Medium"),
                                    children: const [
                                      TextSpan(text: "Select a service"),
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(
                                              color: Color(0XFFE50000)))
                                    ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CommonDropdown(
                                width: 325,
                                hintText: "Service",
                                items: serviceList,
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedService = value;
                                    final selectedServiceEntity =
                                        services.firstWhere(
                                      (service) =>
                                          service.service.serviceName ==
                                          selectedService,
                                    );
                                    selectedFreelancerServiceId =
                                        selectedServiceEntity
                                            .freelancerServiceId;
                                    selectedServiceId =
                                        selectedServiceEntity.service.serviceId;
                                    hourlyRate =
                                        selectedServiceEntity.hourlyRate;
                                  }
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 27, vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: textfieldColour,
                                          fontFamily: "Inter Medium"),
                                      children: const [
                                        TextSpan(
                                            text: "Reason for appointment"),
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Color(0XFFE50000)))
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _appointmentPurposeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '*required';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Enter the booking agenda"),
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: textfieldColour,
                                        fontFamily: "Inter Medium"),
                                    children: const [
                                      TextSpan(text: "Appointment date"),
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(
                                              color: Color(0XFFE50000)))
                                    ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: _showDatePicker,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFE7E7FF),
                                    fixedSize: const Size(325, 45),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            color: Color(0xFF322E86)))),
                                child: Text(
                                  selectedDate != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(selectedDate!)
                                      : "Choose date",
                                  style: const TextStyle(
                                      color: Color(0xFF322E86),
                                      fontSize: 17,
                                      fontFamily: "Inter SemiBold"),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 27, vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 21,
                                          color: textfieldColour,
                                          fontFamily: "Inter Medium"),
                                      children: const [
                                        TextSpan(text: "Project duration"),
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                color: Color(0XFFE50000)))
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      child: TextFormField(
                                        controller:
                                            _projectDurationValueController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '*required';
                                          }

                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            hintText: "Enter a number"),
                                      ),
                                    ),
                                    CommonDropdown(
                                      width: 180,
                                      hintText: "Select a duration",
                                      items: durationList,
                                      onChanged: (value) {
                                        if (value != null) {
                                          duration = value;
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Appointment time",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: textfieldColour,
                                      fontFamily: "Inter Medium"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: _showTimePicker,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFFE7E7FF),
                                      fixedSize: const Size(325, 45),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: const BorderSide(
                                              color: Color(0xFF322E86)))),
                                  child: Text(
                                    appointmentTimeString ?? "Choose time",
                                    style: const TextStyle(
                                        color: Color(0xFF322E86),
                                        fontSize: 17,
                                        fontFamily: "Inter SemiBold"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormField<bool>(
                                initialValue: _isChecked,
                                validator: (value) {
                                  if (value == null || !value) {
                                    return "Please accept the SkillGrid Terms of Service before continuing";
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<bool> state) {
                                  return Row(children: [
                                    Checkbox(
                                      value: state.value,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                        state.didChange(value);
                                      },
                                      side: BorderSide(
                                        color: state.hasError
                                            ? Colors.red
                                            : const Color(0xFF625D5D),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 289,
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Color(0xFF625D5D),
                                            fontSize: 14,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'Yes, I understand and agree to the ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'SkillGrid Terms of Service',
                                              style: TextStyle(
                                                color: termsColour,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  ', including the User Agreement and ',
                                            ),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                color: termsColour,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: '.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 155,
                                height: 43,
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<SendAnOfferBloc>(context)
                                        .add(NavigateToFreelancerProfile(
                                            freelancerId:
                                                freelancer.freelancerId!,
                                            context: context,
                                            destination: FreelancerProfileView(
                                                freelancerId:
                                                    freelancer.freelancerId!)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFE7E7FF),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Color(0XFF544FBD),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Color(0XFF544FBD)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 155,
                                height: 43,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFF544FBD),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<SendAnOfferBloc>(context)
                                        .add(NavigateToBillingAndPayment(
                                            context: context,
                                            freelancerEntity: freelancer,
                                            appointmentEntity:
                                                appointmentEntity));
                                  },
                                  child: const Text(
                                    "Continue",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(""),
              );
            }
          },
        );
      },
    );
  }
}
