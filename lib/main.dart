import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app.dart';
import 'package:noting/app/modules/notes/domain/repository/notes_repository.dart';

import 'core/core.dart';

void main() async {
  await Future.wait([
    Setups.initialize(),
  ]);
  runApp(
    const ProviderScope(
      child: NotingApp(),
    ),
  );
}

class NotingApp extends HookConsumerWidget {
  const NotingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch<AppTheme>(appThemeNotifer);

    useEffect(() {
      ref.read(notesRepository).getRemoteNotes();

      return () {};
    }, []);

    return MaterialApp(
      title: 'noting',
      debugShowCheckedModeBanner: false,
      themeMode: appTheme.mode,
      theme: ThemeData(
        fontFamily: "SFPro",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: appTheme.brightness,
        ),
        brightness: appTheme.brightness,
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}
