import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_view.dart';

part 'client_sidebar_event.dart';
part 'client_sidebar_state.dart';

class ClientSidebarBloc extends Bloc<ClientSidebarEvent, ClientSidebarState> {
  ClientSidebarBloc() : super(SidebarClosed()) {
    on<ToggleSidebar>((event, emit) {
      if(state is SidebarClosed) {
        emit(SidebarOpened());
      }
      else {
        emit(SidebarClosed());
      }
    });

    on<NavigateToClientProfile>((event, emit) {
      Navigator.push(
        event.context, 
        MaterialPageRoute(builder: (context) => const ClientProfileView()),
      );
      emit(NavigatingToClientProfile());
    });
  }
}
