import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/data/models/note_model.dart';
import 'package:noting/app/modules/notes/domain/provider/note_provider.dart';
import 'package:noting/app/modules/notes/presentation/components/notes_appbar.dart';

import 'package:noting/core/core.dart';

class ViewNotePage extends HookConsumerWidget {
  final Note note;
  const ViewNotePage({
    super.key,
    required this.note,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final notesController = useTextEditingController();

    useEffect(() {
      titleController.text = note.title;
      notesController.text = note.content;

      return () {};
    }, [titleController, notesController]);

    return ThemeBuilder(
      appBar: NotesAppBar(
        onPopContext: () {
          ref.read(noteProvider.notifier).addOrUpdate(
                note.copyWith(
                  title: titleController.text,
                  content: notesController.text,
                  date: DateTime.now(),
                ),
              );
          pop<Note>(context, null);
        },
      ),
      builder: (context, color, ref) {
        return PopScope(
          onPopInvoked: (didPop) {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing14,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    cursorColor: color.alwaysFFC400,
                    canRequestFocus: true,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: TextSizes.size24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -.1,
                    ),
                  ),
                  TextField(
                    controller: notesController,
                    textInputAction: TextInputAction.newline,
                    cursorColor: color.alwaysFFC400,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 25,
                    style: TextStyle(
                      fontSize: TextSizes.size14,
                      color: color.lightBlackDarkWhite,
                      letterSpacing: -.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
