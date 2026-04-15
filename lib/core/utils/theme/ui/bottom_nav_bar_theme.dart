import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

final bottomNavBarThemeLight = BottomNavigationBarThemeData(
  backgroundColor: LightThemeColors.surfaceContainerLowest,
  selectedItemColor: LightThemeColors.secondary,
  unselectedItemColor: LightThemeColors.onSurfaceVariant,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  elevation: 8,
  selectedLabelStyle: AppTextStyle.labelSmall().copyWith(
    fontWeight: FontWeight.w600,
    color: LightThemeColors.secondary,
  ),
  unselectedLabelStyle: AppTextStyle.labelSmall().copyWith(
    fontWeight: FontWeight.w500,
    color: LightThemeColors.onSurfaceVariant,
  ),
);

final bottomNavBarThemeDark = BottomNavigationBarThemeData(
  backgroundColor: DarkThemeColors.surfaceContainerLow,
  selectedItemColor: DarkThemeColors.primary,
  unselectedItemColor: DarkThemeColors.onSurfaceVariant,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  elevation: 8,
  selectedLabelStyle: AppTextStyle.labelSmall().copyWith(
    fontWeight: FontWeight.w600,
    color: DarkThemeColors.primary,
  ),
  unselectedLabelStyle: AppTextStyle.labelSmall().copyWith(
    fontWeight: FontWeight.w500,
    color: DarkThemeColors.onSurfaceVariant,
  ),
);
