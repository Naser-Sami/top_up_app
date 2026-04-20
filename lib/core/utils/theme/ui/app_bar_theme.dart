import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:top_up_app/core/constants/_constants.dart';

final appBarThemeDark = AppBarTheme(
  backgroundColor: DarkThemeColors.surfaceDim,
  foregroundColor: DarkThemeColors.onSurface,
  elevation: 0,
  scrolledUnderElevation: 0.0,
  centerTitle: false,
  titleTextStyle: AppTextTheme.darkTextTheme.titleLarge,
  toolbarTextStyle: AppTextTheme.darkTextTheme.titleLarge,
  iconTheme: const IconThemeData(color: DarkThemeColors.onSurface),
  actionsIconTheme: const IconThemeData(color: DarkThemeColors.onSurface),
  systemOverlayStyle: SystemUiOverlayStyle.light,
);

final appBarThemeLight = AppBarTheme(
  backgroundColor: LightThemeColors.surfaceDim,
  foregroundColor: LightThemeColors.onSurface,
  elevation: 0,
  scrolledUnderElevation: 0.0,
  centerTitle: false,
  titleTextStyle: AppTextTheme.lightTextTheme.titleLarge,
  toolbarTextStyle: AppTextTheme.lightTextTheme.titleLarge,
  iconTheme: const IconThemeData(color: LightThemeColors.onSurface),
  actionsIconTheme: const IconThemeData(color: LightThemeColors.onSurface),
  systemOverlayStyle: SystemUiOverlayStyle.dark,
);
