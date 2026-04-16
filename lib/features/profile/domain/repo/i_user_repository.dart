
import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}