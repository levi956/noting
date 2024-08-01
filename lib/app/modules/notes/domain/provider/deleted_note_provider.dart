import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/domain/provider/note_provider.dart';

import '../../data/models/note_model.dart';

final deletedNotesProvider =
    StateNotifierProvider<DeletedNotesNotifier, List<Note>>((ref) {
  return DeletedNotesNotifier(ref);
});

class DeletedNotesNotifier extends StateNotifier<List<Note>> {
  StateNotifierProviderRef ref;

  DeletedNotesNotifier(this.ref) : super([]) {
    loadDeletedNotes();
  }

  final box = Hive.box<Note>('notes');

  void loadDeletedNotes() {
    List<Note> deleted = box.values
        .where((note) => note.deletedAt != null)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    state = [...deleted];
  }

  void restoreNote(Note note) {
    note.deletedAt = null;
    note.save();
    ref.read(noteProvider.notifier).build();
    loadDeletedNotes();
  }

  void permanentlyDelete(Note note) {
    note.delete();
    loadDeletedNotes();
  }
}

Future<void> cleanUpRecentlyDeletedNotes() async {
  final box = Hive.box<Note>('notes');
  final now = DateTime.now();
  final threshold = now.subtract(const Duration(days: 5));
  final notesToDelete = box.values
      .where((note) =>
          note.deletedAt != null && note.deletedAt!.isBefore(threshold))
      .toList();

  for (var note in notesToDelete) {
    await note.delete();
  }
}
