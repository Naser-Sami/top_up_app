import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:top_up_app/core/errors/failure.dart';

abstract class BaseUseCase<T, P> {
  // p for parameters
  Future<Either<Failure, T>> call(P p);
}

// Without parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
