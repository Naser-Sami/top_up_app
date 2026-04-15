import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: AppTextStyle.displayLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    displayMedium: AppTextStyle.displayMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    displaySmall: AppTextStyle.displaySmall().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineLarge: AppTextStyle.headlineLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineMedium: AppTextStyle.headlineMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineSmall: AppTextStyle.headlineSmall().apply(
      color: LightThemeColors.onSurface,
    ),
    titleLarge: AppTextStyle.titleLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    titleMedium: AppTextStyle.titleMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    titleSmall: AppTextStyle.titleSmall().apply(
      color: LightThemeColors.onSurface,
    ),
    bodyLarge: AppTextStyle.bodyLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    bodyMedium: AppTextStyle.bodyMedium().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    bodySmall: AppTextStyle.bodySmall().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelLarge: AppTextStyle.labelLarge().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelMedium: AppTextStyle.labelMedium().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelSmall: AppTextStyle.labelSmall().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: AppTextStyle.displayLarge().apply(
      color: DarkThemeColors.onSurface,
    ),
    displayMedium: AppTextStyle.displayMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    displaySmall: AppTextStyle.displaySmall().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineLarge: AppTextStyle.headlineLarge().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineMedium: AppTextStyle.headlineMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineSmall: AppTextStyle.headlineSmall().apply(
      color: DarkThemeColors.onSurface,
    ),
    titleLarge: AppTextStyle.titleLarge().apply(
      color: DarkThemeColors.onSurface,
    ),
    titleMedium: AppTextStyle.titleMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    titleSmall: AppTextStyle.titleSmall().apply(
      color: DarkThemeColors.onSurface,
    ),
    bodyLarge: AppTextStyle.bodyLarge().apply(color: DarkThemeColors.onSurface),
    bodyMedium: AppTextStyle.bodyMedium().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    bodySmall: AppTextStyle.bodySmall().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelLarge: AppTextStyle.labelLarge().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelMedium: AppTextStyle.labelMedium().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelSmall: AppTextStyle.labelSmall().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
  );
}
