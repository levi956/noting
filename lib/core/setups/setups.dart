import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noting/app/modules/notes/domain/provider/deleted_note_provider.dart';

import '../../app/modules/notes/data/models/note_model.dart';

class Setups {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    await _openNotesBox();
    await cleanUpRecentlyDeletedNotes();
  }
}

Future<void> _openNotesBox() async {
  if (!Hive.isBoxOpen('notes')) {
    await Hive.openBox<Note>('notes');
  }
}
