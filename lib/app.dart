import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/presentation/pages/folders_page.dart';
import 'package:noting/core/core.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState<Widget>(const FoldersPage());

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(appThemeNotifer.notifier).setThemeFromBrightness(brightness);
      });
      return null;
    }, []);

    return page.value;
  }

  Brightness get brightness {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}
