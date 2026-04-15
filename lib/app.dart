import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/theme_cubit/theme_cubit.dart';
import 'core/routes/router.dart';
import 'core/utils/theme/dark_theme.dart';
import 'core/utils/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThemeWrapper();
  }
}

class ThemeWrapper extends StatelessWidget {
  const ThemeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => unfocusKeyboard(context),
          child: MaterialApp.router(
            title: 'Top Up App',
            debugShowCheckedModeBanner: false,
            themeMode: state,
            theme: lightTheme,
            darkTheme: darkTheme,
            routerConfig: router,
          ),
        );
      },
    );
  }

  void unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
