import 'package:flutter/material.dart' show TextStyle, FontWeight;

import 'app_font_size.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle displayLarge() => const TextStyle().copyWith(
    fontSize: AppFontSize.displayLarge,
    fontWeight: FontWeight.w900,
  );

  static TextStyle displayMedium() => const TextStyle().copyWith(
    fontSize: AppFontSize.displayMedium,
    fontWeight: FontWeight.w800,
  );

  static TextStyle displaySmall() => const TextStyle().copyWith(
    fontSize: AppFontSize.displaySmall,
    fontWeight: FontWeight.w700,
  );

  static TextStyle headlineLarge() => const TextStyle().copyWith(
    fontSize: AppFontSize.headlineLarge,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineMedium() => const TextStyle().copyWith(
    fontSize: AppFontSize.headlineMedium,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineSmall() => const TextStyle().copyWith(
    fontSize: AppFontSize.headlineSmall,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleLarge() => const TextStyle().copyWith(
    fontSize: AppFontSize.titleLarge,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium() => const TextStyle().copyWith(
    fontSize: AppFontSize.titleMedium,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleSmall() => const TextStyle().copyWith(
    fontSize: AppFontSize.titleSmall,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelLarge() => const TextStyle().copyWith(
    fontSize: AppFontSize.labelLarge,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelMedium() => const TextStyle().copyWith(
    fontSize: AppFontSize.labelMedium,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelSmall() => const TextStyle().copyWith(
    fontSize: AppFontSize.labelSmall,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyLarge() => const TextStyle().copyWith(
    fontSize: AppFontSize.bodyLarge,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMedium() => const TextStyle().copyWith(
    fontSize: AppFontSize.bodyMedium,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall() => const TextStyle().copyWith(
    fontSize: AppFontSize.bodySmall,
    fontWeight: FontWeight.w400,
  );
}
