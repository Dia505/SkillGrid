import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/common_contract_card.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts/contracts_bloc.dart';

class ClientContractsView extends StatefulWidget {
  const ClientContractsView({super.key});

  @override
  State<ClientContractsView> createState() => _ClientContractsViewState();
}

class _ClientContractsViewState extends State<ClientContractsView> {
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
              children: List.generate(appointments.length, (index) {
                final appointment = appointments[index];
                final payment = payments[index];
                final formattedProjectEndDate = DateFormat("dd-MM-yyyy").format(appointment.projectEndDate!);

                return CommonContractCard(
                  freelancerProfileImgPath: appointment.freelancerService.freelancer.profilePicture!,
                  freelancerFirstName: appointment.freelancerService.freelancer.firstName,
                  freelancerLastName: appointment.freelancerService.freelancer.lastName,
                  profession: appointment.freelancerService.freelancer.profession!,
                  appointmentPurpose: appointment.appointmentPurpose,
                  projectEndDate: formattedProjectEndDate,
                  amount: payment.amount, 
                  paymentMethod: payment.paymentMethod,
                  paymentStatus: payment.paymentStatus 
                );
              }),
            ),
          ),

              );
        } else {
          return const Center(
            child: Text("No contracts found"),
          );
        }
      },
    );
  }
}
