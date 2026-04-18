import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/profile/domain/use_cases/_use_cases.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase getUserUseCase;

  UserCubit({required this.getUserUseCase}) : super(const UserInitial());

  Future<void> fetchUser() async {
    emit(const UserLoading());
    try {
      final response = await getUserUseCase.call(const NoParams());

      return response.fold(
        (failure) => emit(UserError(failure.message)),
        (user) => emit(UserLoaded(user)),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
