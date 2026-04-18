import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toRelativeTime() {
    final now = DateTime.now();

    // Strip time to accurately compare days
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(year, month, day);

    final timeString = DateFormat('h:mm a').format(this); // e.g., "10:30 AM"

    if (dateToCheck == today) {
      return 'Today, $timeString';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday, $timeString';
    } else {
      final dateString = DateFormat('MMM d').format(this); // e.g., "Apr 13"
      return '$dateString, $timeString';
    }
  }

  String get greeting {
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      // 12 PM to 4:59 PM
      return 'Good afternoon';
    } else {
      // 5 PM to 11:59 PM
      return 'Good evening';
    }
  }
}
