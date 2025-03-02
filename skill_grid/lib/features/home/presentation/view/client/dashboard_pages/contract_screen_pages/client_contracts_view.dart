import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/common_contract_card.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/edit_delete_contract_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';

class ClientContractsView extends StatefulWidget {
  const ClientContractsView({super.key});

  @override
  State<ClientContractsView> createState() => _ClientContractsViewState();
}

class _ClientContractsViewState extends State<ClientContractsView> {
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    context.read<ContractsBloc>().loadClientContracts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractsBloc, ContractsState>(
      builder: (context, state) {
        if (state is ContractsLoadedState) {
          final appointments = state.appointments;
          final payments = state.payments;
          List filteredAppointments;
          if (_filter == 'Ongoing') {
            filteredAppointments = appointments
                .where((appointment) =>
                    appointment.projectEndDate != null &&
                    appointment.projectEndDate!.isAfter(DateTime.now()) &&
                    appointment.status == true)
                .toList();
          } else if (_filter == 'Complete') {
            filteredAppointments = appointments
                .where((appointment) =>
                    appointment.projectEndDate != null &&
                    appointment.projectEndDate!.isBefore(DateTime.now()))
                .toList();
          } else if (_filter == 'Requested Offers') {
            filteredAppointments = appointments
                .where((appointment) =>
                    appointment.status == false &&
                    payments.any((payment) =>
                        payment.appointment.appointmentId ==
                            appointment.appointmentId &&
                        payment.paymentStatus == false))
                .toList();
          } else {
            filteredAppointments = appointments;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Contracts",
                  style: TextStyle(
                      color: Color(0xFFE7E7FF),
                      fontSize: 24,
                      fontFamily: "Caprasimo")),
              elevation: 0,
              centerTitle: true,
              backgroundColor: const Color(0xFF322E86),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Column(
                children: [
                  // Scrollable filter buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _filterButton('All'),
                        _filterButton('Ongoing'),
                        _filterButton('Complete'),
                        _filterButton('Requested Offers'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display the filtered contracts
                  filteredAppointments.isEmpty
                      ? const Center(
                          child: Text(
                            "No contracts found",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                filteredAppointments.length,
                                (index) {
                                  final appointment =
                                      filteredAppointments[index];
                                  final payment = payments.firstWhere(
                                    (p) =>
                                        p.appointment.appointmentId ==
                                        appointment.appointmentId,
                                    // Handle missing payments if necessary
                                  );
                                  final formattedProjectEndDate =
                                      DateFormat("dd-MM-yyyy")
                                          .format(appointment.projectEndDate!);
                                  final formattedAppointmentDate =
                                      DateFormat("dd-MM-yyyy")
                                          .format(appointment.appointmentDate);

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<ContractsBloc>(
                                                  context)
                                              .add(NavigateToEditDeleteContract(
                                                  context: context,
                                                  destination:
                                                      EditDeleteContractView(
                                                    freelancerProfileImgPath:
                                                        appointment
                                                            .freelancerService
                                                            .freelancer
                                                            .profilePicture!,
                                                    freelancerFirstName:
                                                        appointment
                                                            .freelancerService
                                                            .freelancer
                                                            .firstName,
                                                    freelancerLastName:
                                                        appointment
                                                            .freelancerService
                                                            .freelancer
                                                            .lastName,
                                                    profession: appointment
                                                        .freelancerService
                                                        .freelancer
                                                        .profession!,
                                                    appointmentPurpose:
                                                        appointment
                                                            .appointmentPurpose,
                                                    projectEndDate:
                                                        formattedProjectEndDate,
                                                    amount: payment.amount,
                                                    paymentMethod:
                                                        payment.paymentMethod,
                                                    paymentStatus:
                                                        payment.paymentStatus,
                                                    appointmentDate:
                                                        formattedAppointmentDate,
                                                    projectDurationUnit:
                                                        appointment
                                                            .projectDuration
                                                            .unit,
                                                    projectDurationValue:
                                                        appointment
                                                            .projectDuration
                                                            .value,
                                                    appointmentId: appointment
                                                        .appointmentId,
                                                    paymentId:
                                                        payment.paymentId!,
                                                    freelancer: appointment
                                                        .freelancerService
                                                        .freelancer,
                                                    appointment: appointment,
                                                  )));
                                        },
                                        child: CommonContractCard(
                                          freelancerProfileImgPath: appointment
                                              .freelancerService
                                              .freelancer
                                              .profilePicture!,
                                          freelancerFirstName: appointment
                                              .freelancerService
                                              .freelancer
                                              .firstName,
                                          freelancerLastName: appointment
                                              .freelancerService
                                              .freelancer
                                              .lastName,
                                          profession: appointment
                                              .freelancerService
                                              .freelancer
                                              .profession!,
                                          appointmentPurpose:
                                              appointment.appointmentPurpose,
                                          projectEndDate:
                                              formattedProjectEndDate,
                                          amount: payment.amount,
                                          paymentMethod: payment.paymentMethod,
                                          paymentStatus: payment.paymentStatus,
                                          appointmentDate:
                                              formattedAppointmentDate,
                                          projectDurationUnit:
                                              appointment.projectDuration.unit,
                                          projectDurationValue:
                                              appointment.projectDuration.value,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                ],
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
  }

  Widget _filterButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _filter = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _filter == label
                ? const Color(0xFF322E86)
                : const Color(0xFFE7E7FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: _filter == label ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
