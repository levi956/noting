import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/data/models/note_model.dart';
import 'package:noting/app/modules/notes/domain/provider/note_provider.dart';
import 'package:noting/app/modules/notes/domain/service/notes_service.dart';
import 'package:noting/core/core.dart';

final notesRepository = Provider<NotesRepository>((ref) {
  return NotesRepository(ref);
});

class NotesRepository {
  ProviderRef ref;

  NotesRepository(this.ref);

  FutureNotifierState<List<Note>> getRemoteNotes() {
    return convert<List<Note>>(
      NotesService.getRemoteNotes,
      then: (response) {
        if (response.error) return;
        final notes = response.data!;
        ref.read(noteProvider.notifier).addOrUpdateList(notes);
      },
    );
  }
}
