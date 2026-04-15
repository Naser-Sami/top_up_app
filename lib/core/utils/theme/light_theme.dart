import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

import 'ui/_ui.dart';

ThemeData _lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: AppTextTheme.lightTextTheme,
  primaryTextTheme: AppTextTheme.lightTextTheme,
  textButtonTheme: lightTextButtonTheme,
  scaffoldBackgroundColor: LightThemeColors.surface,
  dividerTheme: lightDividerTheme,
  dividerColor: LightThemeColors.onSurface.withValues(alpha: 0.25),
  cardTheme: lightCardTheme,
  cardColor: LightThemeColors.surface,
  elevatedButtonTheme: elevatedButtonThemeLight,
  appBarTheme: appBarThemeLight,
  iconButtonTheme: iconButtonThemeLight,
  bottomSheetTheme: bottomSheetThemeLight,
  bottomNavigationBarTheme: bottomNavBarThemeLight,
);

ThemeData get lightTheme => _lightTheme;
