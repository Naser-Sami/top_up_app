import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/profile/data/data_source/_data_source.dart';
import 'package:top_up_app/features/profile/data/mapper/user_mapper.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';
import 'package:top_up_app/features/profile/domain/repo/i_user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  const UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final userModel = await _userRemoteDataSource.fetchUser();
      final userEntity = UserMapper.toEntity(userModel);
      return Right(userEntity);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch user data.'));
    }
  }
}
