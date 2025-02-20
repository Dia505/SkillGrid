import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/common/common_dropdown.dart';

class BillingAndPaymentView extends StatefulWidget {
  const BillingAndPaymentView({super.key});

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
                      Row(
                        children: [
                          Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF929292),
                                  ),
                                  color: const Color(0xFFE7E7FF))),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Cash",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF929292),
                                  ),
                                  color: const Color(0xFFE7E7FF))),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF929292),
                                  ),
                                  color: const Color(0xFFE7E7FF))),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/esewa_logo.png",
                            height: 20,
                          )
                        ],
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
                        decoration:
                            const InputDecoration(hintText: "Enter your address"),
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
                // AppointmentFreelancerCard(
                //   freelancerProfileImgPath: freelancer.profilePicture!,
                //   freelancerName:
                //       "${freelancer.firstName} ${freelancer.lastName}",
                //   profession: freelancer.profession!,
                //   address: freelancer.address,
                //   city: freelancer.city,
                //   mobileNo: freelancer.mobileNo,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontFamily: "Inter Bold"),
                                children: [
                                  TextSpan(text: "Service: "),
                                  TextSpan(
                                      text: "serviceName",
                                      style:
                                          TextStyle(fontFamily: "Inter Regular"))
                                ]),
                          ),
                          const Text("Rs. hourlyRate/hr",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF544FBD),
                                  fontFamily: "Inter Bold"))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              TextSpan(text: "Reason for appointment: "),
                              TextSpan(
                                  text: "appointmentPurpose",
                                  style: TextStyle(fontFamily: "Inter Regular"))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              TextSpan(text: "Appointment date: "),
                              TextSpan(
                                  text: "appointmentDate",
                                  style: TextStyle(fontFamily: "Inter Regular"))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Inter Bold"),
                            children: [
                              TextSpan(text: "Project duration: "),
                              TextSpan(
                                  text:
                                      "projectDuration.value projectDuration.unit",
                                  style: TextStyle(fontFamily: "Inter Regular"))
                            ]),
                      ),
                    ],
                  ),
                ),
                CommonButton(
                    buttonText: "Send offer",
                    onPressed: () {},
                    buttonColor: const Color(0xFF544FBD))
              ],
                        ),
                      ),
            )),
      ),
    );
  }
}
