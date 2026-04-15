import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

final darkTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    elevation: 0,
    overlayColor: DarkThemeColors.onPrimary,
    foregroundColor: DarkThemeColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.r08),
    ),
    textStyle: AppTextStyle.titleMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
  ),
);

final lightTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    elevation: 0,
    overlayColor: LightThemeColors.onPrimary,
    foregroundColor: LightThemeColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.r08),
    ),
    textStyle: AppTextStyle.titleMedium().apply(
      color: LightThemeColors.onSurface,
    ),
  ),
);
