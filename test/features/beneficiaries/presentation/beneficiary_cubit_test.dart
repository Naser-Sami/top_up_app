import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/domain/params/add_beneficiary_params.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/add_beneficiary_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/get_beneficiaries_use_case.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_cubit.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_state.dart';

class MockAddBeneficiaryUseCase extends Mock implements AddBeneficiaryUseCase {}
class MockGetBeneficiariesUseCase extends Mock implements GetBeneficiariesUseCase {}

void main() {
  late MockAddBeneficiaryUseCase mockAddUseCase;
  late MockGetBeneficiariesUseCase mockGetUseCase;
  late BeneficiaryCubit cubit;

  final tBeneficiary = BeneficiaryEntity(id: 'b1', nickname: 'Alice', phoneNumber: '+971501234567');
  final tList = [tBeneficiary];
  final tParams = AddBeneficiaryParams(nickname: 'Alice', phoneNumber: '+971501234567');

  setUp(() {
    mockAddUseCase = MockAddBeneficiaryUseCase();
    mockGetUseCase = MockGetBeneficiariesUseCase();
    cubit = BeneficiaryCubit(
      addBeneficiaryUseCase: mockAddUseCase,
      getBeneficiariesUseCase: mockGetUseCase,
    );
    registerFallbackValue(tParams);
    registerFallbackValue(const NoParams());
  });

  tearDown(() => cubit.close());

  group('BeneficiaryCubit', () {
    // 5.4a
    test('emits [Loading, Loaded] on successful fetchBeneficiaries()', () async {
      when(() => mockGetUseCase(any())).thenAnswer((_) async => Right(tList));

      expectLater(
        cubit.stream,
        emitsInOrder([isA<BeneficiaryLoading>(), isA<BeneficiaryLoaded>()]),
      );

      await cubit.fetchBeneficiaries();
    });

    // 5.4b
    test('emits [Loading, Error] on failed fetchBeneficiaries()', () async {
      when(() => mockGetUseCase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('error')));

      expectLater(
        cubit.stream,
        emitsInOrder([isA<BeneficiaryLoading>(), isA<BeneficiaryError>()]),
      );

      await cubit.fetchBeneficiaries();
    });

    // 5.4c — success: [Loading, Added, Loading, Loaded]
    test('emits [Loading, Added, Loading, Loaded] on successful addBeneficiary()', () async {
      when(() => mockAddUseCase(any())).thenAnswer((_) async => Right(tBeneficiary));
      when(() => mockGetUseCase(any())).thenAnswer((_) async => Right(tList));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<BeneficiaryLoading>(),
          isA<BeneficiaryAdded>(),
          isA<BeneficiaryLoading>(),
          isA<BeneficiaryLoaded>(),
        ]),
      );

      await cubit.addBeneficiary(tParams);
    });

    // 5.4d
    test('emits [Loading, Error] on failed addBeneficiary()', () async {
      when(() => mockAddUseCase(any()))
          .thenAnswer((_) async => const Left(ValidationFailure('Max 5 beneficiaries')));

      expectLater(
        cubit.stream,
        emitsInOrder([isA<BeneficiaryLoading>(), isA<BeneficiaryError>()]),
      );

      await cubit.addBeneficiary(tParams);
    });
  });
}
