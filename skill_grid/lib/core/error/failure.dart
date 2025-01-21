class Failure {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
  List<Object?> get props => [message, statusCode];
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode
  });
}