import 'package:flutter/material.dart';

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final int? badgeCount;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    this.badgeCount,
    this.onTap,
  });
}
