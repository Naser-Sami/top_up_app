import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';

import 'package:top_up_app/features/history/_history.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final TopUpUseCase topUpUseCase;

  TransactionCubit({
    required this.getTransactionsUseCase,
    required this.topUpUseCase,
  }) : super(const TransactionInitial());

  Future<void> fetchTransactions() async {
    emit(const TransactionLoading());
    try {
      final response = await getTransactionsUseCase.call(const NoParams());

      return response.fold(
        (failure) => emit(TransactionError(failure.message)),
        (transactions) => emit(TransactionLoaded(transactions)),
      );
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> topUp(TopUpParams params) async {
    final current = state is TransactionLoaded
        ? (state as TransactionLoaded).transactions
        : <TransactionEntity>[];

    emit(const TransactionLoading());

    try {
      final response = await topUpUseCase.call(params);

      return response.fold(
        (failure) => emit(TransactionError(failure.message)),
        (transaction) {
          emit(TopUpSuccess(transaction));
          emit(TransactionLoaded([...current, transaction]));
        },
      );
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
