import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/appointment_freelancer_card.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';

class SendOfferView extends StatefulWidget {
  const SendOfferView({super.key});

  @override
  State<SendOfferView> createState() => _SendOfferViewState();
}

class _SendOfferViewState extends State<SendOfferView> {
  final serviceList = [
    const DropdownMenuItem(
        value: "Website design", child: Text("Website design")),
    const DropdownMenuItem(
        value: "Mobile app design", child: Text("Mobile app design")),
    const DropdownMenuItem(
        value: "Graphic design", child: Text("Graphic design"))
  ];

  String? service;

  DateTime? selectedDate;

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

  String? duration;

  TimeOfDay? selectedTime;

  void _showTimePicker() {
    showTimePicker(
            context: context, initialTime: selectedTime ?? TimeOfDay.now())
        .then((value) {
      setState(() {
        selectedTime = value;
      });
    });
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: Column(
              children: [
                const Text(
                  "Send an Offer",
                  style: TextStyle(fontSize: 20, fontFamily: "Inter SemiBold"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppointmentFreelancerCard(),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontFamily: "Inter Medium"),
                          children: [
                            TextSpan(text: "Select a service"),
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Color(0XFFE50000)))
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
                          service = value;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "Inter Medium"),
                          children: [
                            TextSpan(text: "Charge:"),
                            TextSpan(
                                text: " Rs. 4500/hr",
                                style: TextStyle(
                                    color: Color(0XFF544FBD),
                                    fontFamily: "Inter Bold"))
                          ]),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontFamily: "Inter Medium"),
                            children: [
                              TextSpan(text: "Reason for appointment"),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Color(0XFFE50000)))
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontFamily: "Inter Medium"),
                          children: [
                            TextSpan(text: "Appointment date"),
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Color(0XFFE50000)))
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
                              side:
                                  const BorderSide(color: Color(0xFF322E86)))),
                      child: Text(
                        selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontFamily: "Inter Medium"),
                            children: [
                              TextSpan(text: "Project duration"),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Color(0XFFE50000)))
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 130,
                            child: TextFormField(
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
                      const Text(
                        "Appointment time",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
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
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                    color: Color(0xFF322E86)))),
                        child: Text(
                          selectedTime?.format(context) ?? "Choose time",
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
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF625D5D),
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Yes, I understand and agree to the ',
                                  ),
                                  TextSpan(
                                    text: 'SkillGrid Terms of Service',
                                    style: TextStyle(
                                      color: Color(0xFF322E86),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ', including the User Agreement and ',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: Color(0xFF322E86), // Purple color
                                      decoration: TextDecoration
                                          .underline, // Underline decoration
                                    ),
                                  ),
                                  TextSpan(
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFE7E7FF),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0XFF544FBD) ?? Colors.transparent,
                              width: 2, // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8), // Optional rounded corners
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
                        onPressed: () {},
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
  }
}
