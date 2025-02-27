import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/appointment_freelancer_card.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/save_appointment_use_case.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/billing_and_payment/billing_and_payment_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/save_billing_address_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/save_payment_use_case.dart';

class BillingAndPaymentView extends StatefulWidget {
  final FreelancerEntity freelancer;
  final AppointmentEntity appointment;
  const BillingAndPaymentView(
      {super.key, required this.freelancer, required this.appointment});

  @override
  State<BillingAndPaymentView> createState() => _BillingAndPaymentViewState();
}

class _BillingAndPaymentViewState extends State<BillingAndPaymentView> {
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

  String? selectedCity;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _billingAddressController =
      TextEditingController();

  String? selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: Column(
              children: [
                const Text(
                  "Billing and Payment",
                  style: TextStyle(fontSize: 20, fontFamily: "Inter SemiBold"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
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
                              TextSpan(text: "Select a payment method"),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Color(0XFFE50000)))
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = "Cash";
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF929292),
                                  ),
                                  color: selectedPayment == "Cash"
                                      ? const Color(0xFF544FBD)
                                      : const Color(0xFFE7E7FF),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Cash",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = "Credit/Debit card";
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF929292),
                                  ),
                                  color: selectedPayment == "Credit/Debit card"
                                      ? const Color(0xFF544FBD)
                                      : const Color(0xFFE7E7FF),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Credit/Debit card",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Image.asset(
                              "assets/images/mastercard_logo.png",
                              height: 28,
                            ),
                            Image.asset(
                              "assets/images/visa_logo.png",
                              height: 18,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = "eSewa";
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF929292),
                                    ),
                                    color: selectedPayment == "eSewa"
                                        ? const Color(0xFF544FBD)
                                        : const Color(0xFFE7E7FF))),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/images/esewa_logo.png",
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 28),
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
                              TextSpan(text: "Billing address"),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(color: Color(0XFFE50000)))
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _billingAddressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*required';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter your address"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CommonDropdown(
                        width: 325,
                        hintText: "Select a city",
                        items: cityList,
                        onChanged: (value) {
                          if (value != null) {
                            selectedCity = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 126, 125, 125),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppointmentFreelancerCard(
                  freelancerProfileImgPath: widget.freelancer.profilePicture!,
                  freelancerName:
                      "${widget.freelancer.firstName} ${widget.freelancer.lastName}",
                  profession: widget.freelancer.profession!,
                  address: widget.freelancer.address,
                  city: widget.freelancer.city,
                  mobileNo: widget.freelancer.mobileNo,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontFamily: "Inter Bold"),
                                children: [
                                  const TextSpan(text: "Service: "),
                                  TextSpan(
                                      text: widget.appointment.freelancerService
                                          .service.serviceName,
                                      style: const TextStyle(
                                          fontFamily: "Inter Regular"))
                                ]),
                          ),
                          Text(
                              "Rs. ${widget.appointment.freelancerService.hourlyRate}/hr",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF544FBD),
                                  fontFamily: "Inter Bold"))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Reason for appointment: "),
                              TextSpan(
                                  text: widget.appointment.appointmentPurpose,
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular"))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Appointment date: "),
                              TextSpan(
                                  text: DateFormat('d MMMM yyyy').format(
                                      widget.appointment.appointmentDate),
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular"))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Project duration: "),
                              TextSpan(
                                  text:
                                      "${widget.appointment.projectDuration.value} ${widget.appointment.projectDuration.unit}",
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular"))
                            ]),
                      ),
                    ],
                  ),
                ),
                BlocListener<BillingAndPaymentBloc, BillingAndPaymentState>(
                  listener: (context, state) {
                    final paymentParams = SavePaymentParams(
                      amount: 0,
                      paymentMethod: selectedPayment!,
                      paymentStatus: false,
                      appointment: state.appointment!,
                      billingAddress: state.billingAddress!,
                    );

                    // Trigger the SavePayment event after both appointment and billing address are saved
                    context.read<BillingAndPaymentBloc>().add(SavePayment(
                          paymentParams: paymentParams,
                          context: context,
                        ));
                  },
                  child: CommonButton(
                    buttonText: "Send offer",
                    buttonColor: const Color(0xFF544FBD),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final appointmentParams = SaveAppointmentParams(
                          appointmentPurpose:
                              widget.appointment.appointmentPurpose,
                          appointmentDate: widget.appointment.appointmentDate,
                          projectDuration: widget.appointment.projectDuration,
                          appointmentTime: widget.appointment.appointmentTime,
                          status: false,
                          freelancerService:
                              widget.appointment.freelancerService,
                          client: widget.appointment.client,
                        );

                        final billingAddressParams = SaveBillingAddressParams(
                          address: _billingAddressController.text.trim(),
                          city: selectedCity!,
                        );

                        // Trigger SaveAppointment and SaveBillingAddress events simultaneously
                        context
                            .read<BillingAndPaymentBloc>()
                            .add(SaveAppointment(
                              appointmentParams: appointmentParams,
                              context: context,
                            ));

                        context
                            .read<BillingAndPaymentBloc>()
                            .add(SaveBillingAddress(
                              billingAddressParams: billingAddressParams,
                              context: context,
                            ));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
