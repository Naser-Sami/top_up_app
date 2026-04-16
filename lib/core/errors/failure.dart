import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [statusCode, message];
}

// Used for API or Backend errors
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

// Used for Business Logic and Validation errors
class ValidationFailure extends Failure {
  // Validation failures don't typically need HTTP status codes,
  // but if you want one, 400 (Bad Request) is the correct semantic code.
  const ValidationFailure(super.message) : super(statusCode: 400);
}
