import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/domain/provider/deleted_note_provider.dart';

import '../../data/models/note_model.dart';

final noteProvider =
    NotifierProvider<NoteNotifier, List<Note>>(NoteNotifier.new);

class NoteNotifier extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    _loadNotes();
    return [];
  }

  final box = Hive.box<Note>('notes');

  void _loadNotes() {
    state = box.values.where((note) => note.deletedAt == null).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  void addOrUpdate(Note note) {
    box.put(note.id, note);
    _loadNotes();
  }

  void addOrUpdateList(List<Note> notes) {
    Map<dynamic, Note> noteMap = {for (var note in notes) note.id: note};
    box.putAll(noteMap);
    _loadNotes();
  }

  void delete(Note note) {
    note.deletedAt = DateTime.now();
    note.save();
    ref.read(deletedNotesProvider.notifier).loadDeletedNotes();
    _loadNotes();
  }
}
