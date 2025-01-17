import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/freelancer/freelancer_dashboard_state.dart';

class FreelancerDashboardCubit extends Cubit<FreelancerDashboardState> {
  FreelancerDashboardCubit() : super(FreelancerDashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}