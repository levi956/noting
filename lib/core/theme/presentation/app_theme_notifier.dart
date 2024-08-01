import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/core/core.dart';

final appThemeNotifer = NotifierProvider<AppThemeStateNotifier, AppTheme>(
    AppThemeStateNotifier.new);

class AppThemeStateNotifier extends Notifier<AppTheme>
    with WidgetsBindingObserver {
  @override
  AppTheme build() {
    WidgetsBinding.instance.addObserver(this);
    return AppTheme.light();
  }

  Brightness get brightness {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    ref.read(appThemeNotifer.notifier).setThemeFromBrightness(brightness);
  }

  void setLightMode() {
    state = AppTheme.light();
  }

  void setDarkMode() {
    state = AppTheme.dark();
  }

  void setThemeFromBrightness(Brightness brightness) {
    if (brightness == Brightness.light) {
      setLightMode();
      return;
    }
    setDarkMode();
  }

  void setThemeFromOptions(
    String option, {
    Brightness brightness = Brightness.light,
  }) {
    switch (option) {
      case 'System':
        setThemeFromBrightness(brightness);
        break;
      case 'Dark':
        setDarkMode();
        break;
      case 'Light':
        setLightMode();
        break;
      default:
        break;
    }
  }
}
