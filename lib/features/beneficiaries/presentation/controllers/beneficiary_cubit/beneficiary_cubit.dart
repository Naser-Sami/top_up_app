import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

import 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final AddBeneficiaryUseCase addBeneficiaryUseCase;
  final GetBeneficiariesUseCase getBeneficiariesUseCase;

  BeneficiaryCubit({
    required this.addBeneficiaryUseCase,
    required this.getBeneficiariesUseCase,
  }) : super(const BeneficiaryInitial());

  Future<void> addBeneficiary(AddBeneficiaryParams params) async {
    emit(const BeneficiaryLoading());
    try {
      final response = await addBeneficiaryUseCase.call(params);

      return response.fold(
        (failure) => emit(BeneficiaryError(failure.message)),
        (_) {
          emit(const BeneficiaryAdded());
          fetchBeneficiaries();
        },
      );
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }

  Future<void> fetchBeneficiaries() async {
    emit(const BeneficiaryLoading());
    try {
      final response = await getBeneficiariesUseCase.call(const NoParams());

      return response.fold(
        (failure) => emit(BeneficiaryError(failure.message)),
        (beneficiaries) => emit(BeneficiaryLoaded(beneficiaries)),
      );
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }
}
