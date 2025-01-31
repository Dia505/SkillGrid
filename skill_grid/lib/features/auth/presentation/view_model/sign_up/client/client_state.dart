part of 'client_bloc.dart';

class ClientState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  ClientState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName
  });

  ClientState.initial()
    : isLoading = false,
      isSuccess = false,
      imageName = null;

  ClientState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName
  }) {
    return ClientState(
      isLoading: isLoading ?? this.isLoading, 
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isSuccess, imageName];
}