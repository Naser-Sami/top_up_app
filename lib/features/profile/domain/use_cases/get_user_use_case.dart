import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';
import 'package:top_up_app/features/profile/domain/repo/i_user_repository.dart';

class GetUserUseCase extends BaseUseCase<UserEntity, NoParams> {
  final IUserRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getUser();
  }
}
