import 'package:noting/app/modules/notes/data/models/note_model.dart';
import 'package:noting/app/shared/shared.dart';
import 'package:noting/core/core.dart';

// SIMULATING AND DEMONSTRATING API INTEGRATION
class NotesService {
  static FutureHandler<List<Note>> getRemoteNotes() {
    return serveFuture(
      function: (fail) async {
        final r = await HTTP.get("posts/1/comments");
        if (r.is200or201) {
          List body = r.data;
          return body.map((e) => Note.fromJson(e)).toList();
        }
        return fail("Error", response: r);
      },
    );
  }
}
