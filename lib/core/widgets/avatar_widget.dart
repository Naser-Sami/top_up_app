import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';

class AvatarWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const AvatarWidget({super.key, required this.child, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSize.s52,
      height: height ?? AppSize.s52,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [LightThemeColors.primary, LightThemeColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
