import 'dart:math';

import 'package:intl/intl.dart';

DateTime generateRandomDateTimeWithinCurrentWeek() {
  // Get the start of the current week and the current time
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

  // Ensure the end of the range is the current time to avoid future dates
  final endOfRange = now;

  // Generate a random number of milliseconds within the range from start of the week to now
  final randomMilliseconds = Random().nextInt(
      (endOfRange.millisecondsSinceEpoch - startOfWeek.millisecondsSinceEpoch)
          .abs());

  // Create a DateTime object from the random milliseconds
  return DateTime.fromMillisecondsSinceEpoch(
    startOfWeek.millisecondsSinceEpoch + randomMilliseconds,
  );
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('MMMM d, yyyy \'at\' h:mm a');
  return formatter.format(dateTime);
}
