import 'package:flutter/material.dart';
import 'package:noting/core/theme/colors/app_color.dart';

class AppTheme {
  final ThemeMode mode;
  final AppColors appColors;
  final Brightness brightness;

  const AppTheme._({
    required this.mode,
    required this.appColors,
    required this.brightness,
  });

  factory AppTheme.light() {
    return AppTheme._(
      mode: ThemeMode.light,
      brightness: Brightness.light,
      appColors: AppColors(
        alwaysBlack: Colors.black,
        alwaysWhite: Colors.white,
        always7F7F7F: const Color(0xFF7F7F7F),
        alwaysFFC400: const Color(0xFFFFC400),
        alwaysCC2929: const Color(0xFFCC2929),
        lightBlackDarkWhite: Colors.black,
        lightWhiteDarkBlack: Colors.white,
        lightF9F9F9Dark000000: const Color(0xFFF9F9F9),
        lightFFFFFFDark1C1C1C: Colors.white,
      ),
    );
  }

  factory AppTheme.dark() {
    return AppTheme._(
      mode: ThemeMode.dark,
      brightness: Brightness.dark,
      appColors: AppColors(
        alwaysBlack: Colors.black,
        alwaysWhite: Colors.white,
        alwaysFFC400: const Color(0xFFFFC400),
        always7F7F7F: const Color(0xFF7F7F7F),
        alwaysCC2929: const Color(0xFFCC2929),
        lightBlackDarkWhite: Colors.white,
        lightWhiteDarkBlack: Colors.black,
        lightF9F9F9Dark000000: Colors.black,
        lightFFFFFFDark1C1C1C: const Color(0xFF1C1C1C),
      ),
    );
  }
}
