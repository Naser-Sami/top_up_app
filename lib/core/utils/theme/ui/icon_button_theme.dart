import 'package:flutter/material.dart';

import 'package:top_up_app/core/constants/_constants.dart';

final iconButtonThemeDark = IconButtonThemeData(
  style: IconButton.styleFrom(
    foregroundColor: DarkThemeColors.onSurface,
    backgroundColor: Colors.transparent,
    shape: const CircleBorder(),
  ),
);

final iconButtonThemeLight = IconButtonThemeData(
  style: IconButton.styleFrom(
    foregroundColor: LightThemeColors.onSurface,
    backgroundColor: Colors.transparent,
    shape: const CircleBorder(),
  ),
);
