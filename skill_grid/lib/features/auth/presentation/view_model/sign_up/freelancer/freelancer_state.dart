part of 'freelancer_bloc.dart';

class FreelancerState {
  final bool isLoading;
  final bool isSuccess;

  FreelancerState({
    required this.isLoading,
    required this.isSuccess,
  });

  FreelancerState.initial()
    : isLoading = false,
      isSuccess = false;

  FreelancerState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return FreelancerState(
      isLoading: isLoading ?? this.isLoading, 
      isSuccess: isSuccess ?? this.isSuccess
    );
  }
}