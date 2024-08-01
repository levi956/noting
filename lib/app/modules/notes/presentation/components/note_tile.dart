import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/domain/provider/deleted_note_provider.dart';
import 'package:noting/core/core.dart';

import '../../data/models/note_model.dart';
import '../../domain/provider/note_provider.dart';
import '../pages/view_note_page.dart';

class NoteTile extends HookConsumerWidget {
  final Note note;
  final bool shouldSwipeToRestore;

  const NoteTile({
    super.key,
    required this.note,
    this.shouldSwipeToRestore = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, _) {
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  if (shouldSwipeToRestore) {
                    ref.read(deletedNotesProvider.notifier).restoreNote(note);
                    return;
                  }

                  ref.read(noteProvider.notifier).delete(note);
                },
                foregroundColor: color.alwaysWhite,
                backgroundColor: shouldSwipeToRestore
                    ? color.alwaysFFC400
                    : color.alwaysCC2929,
                icon: shouldSwipeToRestore
                    ? CupertinoIcons.folder_badge_plus
                    : CupertinoIcons.delete_solid,
              )
            ],
          ),
          child: GestureDetector(
            onTap: () async {
              if (shouldSwipeToRestore) {
                return;
              }

              await pushTo<Note>(context, ViewNotePage(note: note));
            },
            child: Container(
              width: double.maxFinite,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.spacing20,
                vertical: Spacings.spacing12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: TextSizes.size14,
                      letterSpacing: -.2,
                    ),
                  ),
                  Text(
                    note.content,
                    maxLines: 1,
                    style: TextStyle(
                      color: color.always7F7F7F,
                      fontSize: TextSizes.size12,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -.2,
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
