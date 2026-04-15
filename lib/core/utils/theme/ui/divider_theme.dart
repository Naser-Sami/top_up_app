import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

DividerThemeData? lightDividerTheme = DividerThemeData(
  space: 0,
  thickness: 1.2,
  color: LightThemeColors.onSurface.withValues(alpha: 0.25),
);

DividerThemeData? darkDividerTheme = DividerThemeData(
  space: 0,
  thickness: 1.2,
  color: DarkThemeColors.onSurface.withValues(alpha: 0.25),
);
