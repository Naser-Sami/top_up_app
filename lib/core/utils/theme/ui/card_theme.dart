import 'package:flutter/material.dart';

import 'package:top_up_app/core/constants/_constants.dart';

CardThemeData? lightCardTheme = CardThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadius.r12),
  ),
  color: LightThemeColors.surfaceDim,
  shadowColor: LightThemeColors.shadow,
);

CardThemeData? darkCardTheme = CardThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadius.r12),
  ),
  color: DarkThemeColors.surfaceDim,
  surfaceTintColor: DarkThemeColors.onSurface,
  shadowColor: DarkThemeColors.shadow,
);
