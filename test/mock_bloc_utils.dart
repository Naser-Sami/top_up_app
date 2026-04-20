import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Helper to simulate whenListen from bloc_test
void whenListen<S>(
  Mock cubit,
  Stream<S> stream, {
  S? initialState,
}) {
  if (initialState != null) {
    when(() => (cubit as dynamic).state).thenReturn(initialState);
  }
  when(() => (cubit as dynamic).stream).thenAnswer((_) => stream);
}
