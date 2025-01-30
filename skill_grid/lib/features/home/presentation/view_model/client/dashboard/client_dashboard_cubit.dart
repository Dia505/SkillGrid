import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_state.dart';

class ClientDashboardCubit extends Cubit<ClientDashboardState> {
  ClientDashboardCubit() : super(ClientDashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}