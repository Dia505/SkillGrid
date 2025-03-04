import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_grid/core/common/notification_card.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';
import 'package:skill_grid/features/notification/presentation/view_model/notification_bloc.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().getClientNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",
            style: TextStyle(
                color: Color(0xFFE7E7FF),
                fontSize: 24,
                fontFamily: "Caprasimo")),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF322E86),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
                child: CircularProgressIndicator()); // ✅ Show loading spinner
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(
                  child: Text("No new notifications")); // ✅ Handle empty state
            }

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final NotificationEntity notification =
                      state.notifications[index];
                  final formattedNotificationDate = DateFormat("dd-MM-yyyy")
                      .format(notification.notificationDate);
                  final formattedContractDate = DateFormat("dd-MM-yyyy")
                      .format(notification.appointment!.appointmentDate);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        final notificationId = notification.notificationId!;
                        BlocProvider.of<NotificationBloc>(context).add(
                            MarkNotificationAsReadEvent(
                                notificationId, context));
                      },
                      child: NotificationCard(
                        notificationDate: formattedNotificationDate,
                        notificationTitle: notification.message,
                        freelancerProfileImgPath: notification.appointment
                                ?.freelancerService.freelancer.profilePicture ??
                            "assets/images/default_profile.png",
                        notificationMessage:
                            "Your project is set to start on $formattedContractDate. Click here to review the details.",
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is NotificationError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red))); // ✅ Show error
          }

          return const Center(
              child: Text("No new notifications")); // Default case
        },
      ),
    );
  }
}
