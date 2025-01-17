part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isLoggedIn;
  final String? role;

  LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.isLoggedIn,
    required this.role,
  });

  LoginState.initial()
      : isLoading = false,
        isSuccess = false,
        isLoggedIn = false, 
        role = null;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isLoggedIn,
    String? role,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      role: role ?? this.role
    );
  }
}