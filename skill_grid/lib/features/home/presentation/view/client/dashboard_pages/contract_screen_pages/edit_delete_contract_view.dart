import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/edit_delete_contract/edit_delete_contract_bloc.dart';

class EditDeleteContractView extends StatefulWidget {
  final String freelancerProfileImgPath;
  final String freelancerFirstName;
  final String freelancerLastName;
  final String profession;
  final String appointmentPurpose;
  final String projectEndDate;
  final int amount;
  final String paymentMethod;
  final bool paymentStatus;
  final String appointmentDate;
  final String? appointmentTime;
  final int projectDurationValue;
  final String projectDurationUnit;
  final String appointmentId;
  final String paymentId;

  const EditDeleteContractView(
      {super.key,
      required this.freelancerProfileImgPath,
      required this.freelancerFirstName,
      required this.freelancerLastName,
      required this.profession,
      required this.appointmentPurpose,
      required this.projectEndDate,
      required this.amount,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.appointmentDate,
      this.appointmentTime,
      required this.projectDurationUnit,
      required this.projectDurationValue,
      required this.appointmentId,
      required this.paymentId});

  @override
  State<EditDeleteContractView> createState() => _EditDeleteContractViewState();
}

class _EditDeleteContractViewState extends State<EditDeleteContractView> {
  double calculateCompletionPercent() {
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(widget.appointmentDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(widget.projectEndDate);

    int totalDays = endDate.difference(startDate).inDays;

    int elapsedDays = DateTime.now().difference(startDate).inDays;

    double percent = (elapsedDays / totalDays) * 100;

    return percent.clamp(0, 100);
  }

  final TextEditingController _appointmentPurposeController =
      TextEditingController();
  String? selectedPayment;

  @override
  void initState() {
    super.initState();
    _appointmentPurposeController.text = widget.appointmentPurpose;
    selectedPayment = widget.paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    double completePercent = calculateCompletionPercent();
    return BlocBuilder<EditDeleteContractBloc, EditDeleteContractState>(
        builder: (context, event) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        BlocProvider.of<EditDeleteContractBloc>(context).add(
                            NavigateToContracts(
                                context: context,
                                destination: const ClientContractsView()));
                      },
                      child: const Icon(Icons.arrow_back, size: 30)),
                  const SizedBox(
                    height: 20,
                  ),
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
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              widget.profession,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Project details",
                        style: TextStyle(
                            fontFamily: "Caprasimo",
                            fontSize: 22,
                            color: Color(0XFF322E86)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
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
                        height: 7,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0XFF322E86),
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Deadline: "),
                              TextSpan(
                                  text: widget.projectEndDate,
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular",
                                      color: Colors.black))
                            ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              width: 180,
                              height: 6,
                              child: LinearProgressIndicator(
                                value: completePercent / 100,
                                backgroundColor: const Color(0xFFC5BDBD),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF236FD2)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("${completePercent.toStringAsFixed(2)}%"),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0XFF322E86),
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Amount: "),
                              TextSpan(
                                  text: "Rs. ${widget.amount}",
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular",
                                      color: Colors.black))
                            ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0XFF322E86),
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Payment method: "),
                              TextSpan(
                                  text: widget.paymentMethod,
                                  style: const TextStyle(
                                      fontFamily: "Inter Regular",
                                      color: Colors.black))
                            ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0XFF322E86),
                                fontFamily: "Inter Bold"),
                            children: [
                              const TextSpan(text: "Payment status: "),
                              TextSpan(
                                text: widget.paymentStatus
                                    ? "Paid"
                                    : "Unpaid", // Conditional text
                                style: TextStyle(
                                  fontFamily: "Inter Regular",
                                  color: widget.paymentStatus
                                      ? Colors.green
                                      : Colors.red, // Conditional color
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 115,
                        height: 43,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFFE7E7FF),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0XFFE50000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Color(0XFFE50000)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 185,
                        height: 43,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF544FBD),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Write review ⭐",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 126, 125, 125),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Update contract",
                        style: TextStyle(
                            fontFamily: "Caprasimo",
                            fontSize: 22,
                            color: Color(0XFF322E86)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Reason for appointment",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: "Inter Medium")),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Payment method",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "Inter Medium")),
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
                                    style: TextStyle(fontSize: 16),
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
                                        color: selectedPayment ==
                                                "Credit/Debit card"
                                            ? const Color(0xFF544FBD)
                                            : const Color(0xFFE7E7FF),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Credit/Debit card",
                                    style: TextStyle(fontSize: 16),
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
                      const SizedBox(
                        height: 30,
                      ),
                      CommonButton(
                        buttonText: "Update",
                        buttonColor: const Color(0xFF544FBD),
                        onPressed: () {
                          bool isAppointmentPurposeChanged =
                              _appointmentPurposeController.text !=
                                  widget.appointmentPurpose;
                          bool isPaymentMethodChanged =
                              selectedPayment != widget.paymentMethod;

                          if (isAppointmentPurposeChanged) {
                            context.read<EditDeleteContractBloc>().add(
                                  UpdateAppointment(
                                      appointmentId: widget.appointmentId,
                                      appointmentPurpose:
                                          _appointmentPurposeController.text,
                                      context: context),
                                );
                          }

                          if (isPaymentMethodChanged) {
                            context.read<EditDeleteContractBloc>().add(
                                  UpdatePayment(
                                      paymentId: widget.paymentId,
                                      appointmentId: widget.appointmentId,
                                      paymentMethod: selectedPayment!,
                                      context: context),
                                );
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
