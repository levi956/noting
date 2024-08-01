import 'dart:math';

DateTime generateRandomDateTimeWithinCurrentWeek() {
  // Get the start and end of the current week
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  // Generate a random number of milliseconds within the week's range
  final randomMilliseconds = Random().nextInt(
      (endOfWeek.millisecondsSinceEpoch - startOfWeek.millisecondsSinceEpoch)
          .abs());

  // Create a DateTime object from the random milliseconds
  return DateTime.fromMillisecondsSinceEpoch(
    startOfWeek.millisecondsSinceEpoch + randomMilliseconds,
  );
}
