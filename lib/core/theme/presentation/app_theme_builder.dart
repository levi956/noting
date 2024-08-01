import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/core/core.dart';

class ThemeBuilder extends HookConsumerWidget {
  final Widget Function(
    BuildContext context,
    AppColors appColor,
    WidgetRef ref,
  ) builder;
  final FloatingActionButton? floatingActionButton;
  final bool useScaffold;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const ThemeBuilder({
    this.floatingActionButton,
    this.appBar,
    this.bottomNavigationBar,
    required this.builder,
    this.useScaffold = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme appTheme = ref.watch<AppTheme>(appThemeNotifer);
    AppColors appColor = appTheme.appColors;
    Widget child = builder(context, appColor, ref);

    return useScaffold
        ? Scaffold(
            floatingActionButton: floatingActionButton,
            body: child,
            appBar: appBar,
            backgroundColor: appColor.lightF9F9F9Dark000000,
            bottomNavigationBar: bottomNavigationBar,
          )
        : child;
  }
}
