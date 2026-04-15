import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

import 'ui/_ui.dart';

ThemeData _darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeColors.surface,
  colorScheme: darkColorScheme,
  textTheme: AppTextTheme.darkTextTheme,
  primaryTextTheme: AppTextTheme.darkTextTheme,
  textButtonTheme: darkTextButtonTheme,
  dividerTheme: darkDividerTheme,
  dividerColor: DarkThemeColors.onSurface.withValues(alpha: 0.25),
  cardTheme: darkCardTheme,
  cardColor: DarkThemeColors.surface,
  elevatedButtonTheme: elevatedButtonThemeDark,
  appBarTheme: appBarThemeDark,
  iconButtonTheme: iconButtonThemeDark,
  bottomSheetTheme: bottomSheetThemeDark,
  bottomNavigationBarTheme: bottomNavBarThemeDark,
);

ThemeData get darkTheme => _darkTheme;
