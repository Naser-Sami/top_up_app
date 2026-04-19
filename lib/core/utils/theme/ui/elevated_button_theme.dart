import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

final elevatedButtonThemeDark = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    fixedSize: const Size(double.maxFinite, AppSize.s50),
    backgroundColor: DarkThemeColors.primary,
    foregroundColor: DarkThemeColors.onPrimary,
    disabledBackgroundColor: DarkThemeColors.primaryContainer,
    disabledForegroundColor: DarkThemeColors.onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.r30),
    ),
    textStyle: AppTextStyle.titleMedium(),
  ),
);

final elevatedButtonThemeLight = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    fixedSize: const Size(double.maxFinite, AppSize.s50),
    backgroundColor: LightThemeColors.primary,
    foregroundColor: LightThemeColors.onPrimary,
    disabledBackgroundColor: LightThemeColors.primaryContainer,
    disabledForegroundColor: LightThemeColors.onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.r30),
    ),
    textStyle: AppTextStyle.titleMedium(),
  ),
);
