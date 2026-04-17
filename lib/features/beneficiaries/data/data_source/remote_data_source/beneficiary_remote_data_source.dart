import 'package:top_up_app/features/beneficiaries/data/models/beneficiary_model.dart';
import 'package:top_up_app/features/beneficiaries/domain/params/add_beneficiary_params.dart';

abstract class IBeneficiaryRemoteDataSource {
  Future<List<BeneficiaryModel>> getBeneficiaries();
  Future<BeneficiaryModel> addBeneficiary(AddBeneficiaryParams params);
}

class BeneficiaryRemoteDataSourceImpl implements IBeneficiaryRemoteDataSource {
  // Our "mock database" running in memory.
  // Pre-seeded with 2 entries as requested.
  final List<BeneficiaryModel> _mockDatabase = [
    const BeneficiaryModel(
      id: 'ben_1',
      nickname: 'Home Internet',
      phoneNumber: '+971501234567',
    ),
    const BeneficiaryModel(
      id: 'ben_2',
      nickname: 'Driver',
      phoneNumber: '+971559876543',
    ),
  ];

  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    // 1. Simulate network latency (e.g., 800ms) to ensure our UI loading states work.
    await Future.delayed(const Duration(milliseconds: 800));

    // 2. Return an unmodifiable list so the UI/Domain layer can't accidentally mutate our "database".
    return List.unmodifiable(_mockDatabase);
  }

  @override
  Future<BeneficiaryModel> addBeneficiary(AddBeneficiaryParams params) async {
    // 1. Simulate network latency for the POST request.
    await Future.delayed(const Duration(milliseconds: 1000));

    // 2. Construct the new mock model.
    final newBeneficiary = BeneficiaryModel(
      id: 'ben_${DateTime.now().millisecondsSinceEpoch}', // Mock a unique ID
      nickname: params.nickname,
      phoneNumber: params.phoneNumber,
    );

    // 3. Save to our in-memory database.
    _mockDatabase.add(newBeneficiary);

    // 4. Return the newly created entity (common REST API pattern).
    return newBeneficiary;
  }
}
