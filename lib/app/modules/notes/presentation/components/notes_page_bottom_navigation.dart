import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/presentation/pages/create_note_page.dart';
import 'package:noting/core/core.dart';

import '../../../../shared/presentation/components/triple_trail_component.dart';
import '../../data/models/note_model.dart';
import '../../domain/provider/note_provider.dart';

class NotesPageBottomNavigation extends HookConsumerWidget {
  const NotesPageBottomNavigation({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesCount = ref.watch(noteProvider).length;

    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return Container(
          height: Spacings.spacing70,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing10,
            ),
            child: TripleTrailComponent(
              middle: Text(
                "$notesCount Notes",
                style: const TextStyle(
                  fontSize: TextSizes.size12,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  final note_ =
                      await pushTo<Note>(context, const CreateNotePage());
                  if (note_ != null) {
                    ref.read(noteProvider.notifier).addOrUpdate(note_);
                  }
                },
                icon: Icon(
                  CupertinoIcons.square_pencil,
                  weight: Spacings.spacing6,
                  color: color.alwaysFFC400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
