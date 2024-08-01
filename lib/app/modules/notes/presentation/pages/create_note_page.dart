import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/data/models/note_model.dart';
import 'package:noting/app/modules/notes/presentation/components/notes_appbar.dart';
import 'package:noting/app/shared/shared.dart';
import 'package:noting/core/core.dart';

class CreateNotePage extends HookConsumerWidget {
  const CreateNotePage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final notesController = useTextEditingController();

    useEffect(() {
      return () {};
    }, [titleController, notesController]);

    return ThemeBuilder(
      appBar: NotesAppBar(
        onPopContext: () {
          if (titleController.text.isNotEmpty ||
              notesController.text.isNotEmpty) {
            final note_ = Note(
              id: Uuid.generateV4(),
              title: titleController.text,
              content: notesController.text,
              createdAt: DateTime.now(),
            );
            pop<Note>(context, note_);
          }
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
