import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int statusCode;
  final String message;
  const Failure({this.statusCode = 500, this.message = ''});

  @override
  List<Object?> get props => [statusCode, message];
}
