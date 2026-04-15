import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int statusCode;
  final String error;
  const Failure({this.statusCode = 500, this.error = ''});

  @override
  List<Object?> get props => [statusCode, error];
}