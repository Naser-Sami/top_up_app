import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';
import 'package:top_up_app/features/profile/domain/repo/i_user_repository.dart';
import 'package:top_up_app/features/profile/domain/use_cases/get_user_use_case.dart';

class MockIUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockIUserRepository mockRepo;
  late GetUserUseCase useCase;

  final tUser = const UserEntity(id: 'u1', name: 'Ahmed', balance: 1500.0, isVerified: true);

  setUp(() {
    mockRepo = MockIUserRepository();
    useCase = GetUserUseCase(mockRepo);
  });

  group('GetUserUseCase', () {
    // 5.3a
    test('returns Right(UserEntity) when repository succeeds', () async {
      when(() => mockRepo.getUser()).thenAnswer((_) async => Right(tUser));

      final result = await useCase(const NoParams());

      expect(result, Right(tUser));
      verify(() => mockRepo.getUser()).called(1);
    });

    // 5.3b
    test('returns Left(Failure) when repository throws', () async {
      when(() => mockRepo.getUser())
          .thenAnswer((_) async => const Left(ServerFailure('Server error', statusCode: 500)));

      final result = await useCase(const NoParams());

      expect(result.isLeft(), true);
    });
  });
}
