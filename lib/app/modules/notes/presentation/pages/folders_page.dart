import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/domain/provider/note_provider.dart';
import 'package:noting/app/modules/notes/presentation/pages/create_note_page.dart';
import 'package:noting/app/modules/notes/presentation/pages/deleted_notes_page.dart';
import 'package:noting/app/modules/notes/presentation/pages/notes_page.dart';

import 'package:noting/app/shared/shared.dart';
import 'package:noting/core/core.dart';

import '../../domain/provider/deleted_note_provider.dart';
import '../components/folder_tile.dart';

class FoldersPage extends HookConsumerWidget {
  const FoldersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final notes = ref.watch(noteProvider);
    final deletedNotes = ref.watch(deletedNotesProvider);

    final items = <({
      IconData icon,
      String text,
      String count,
      Widget page,
    })>[
      (
        icon: CupertinoIcons.folder,
        text: 'Notes',
        count: "${notes.length}",
        page: const NotesPage(),
      ),
      (
        icon: CupertinoIcons.delete,
        text: 'Recently Deleted',
        count: "${deletedNotes.length}",
        page: const DeletedNotesPage(),
      ),
    ];

    return ThemeBuilder(
      builder: (context, color, _) {
        return ListViewWithStickyFooter(
          includeAppBar: true,
          alignment: Alignment.topLeft,
          title: "Folders",
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing14,
          ),
          stickyFooterChildren: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.spacing6,
              ),
              child: TripleTrailComponent(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.folder_badge_plus,
                    weight: Spacings.spacing6,
                    color: color.alwaysFFC400,
                    size: Spacings.spacing28,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await pushTo(context, const CreateNotePage());
                  },
                  icon: Icon(
                    CupertinoIcons.square_pencil,
                    weight: Spacings.spacing6,
                    color: color.alwaysFFC400,
                    size: Spacings.spacing28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Spacings.spacing30),
          ],
          children: [
            CupertinoSearchTextField(
              controller: searchController,
            ),
            const SizedBox(height: Spacings.spacing20),
            const Text(
              "Device",
              style: TextStyle(
                fontSize: TextSizes.size18,
                fontWeight: FontWeight.w600,
                letterSpacing: -.2,
              ),
            ),
            const SizedBox(height: Spacings.spacing6),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color.lightFFFFFFDark1C1C1C,
                borderRadius: BorderRadius.circular(
                  Spacings.spacing10,
                ),
              ),
              child: Column(
                children: [
                  for (final (index, item) in items.enumerate())
                    Column(
                      children: [
                        FolderTile(
                          item: item,
                        ),
                        if (index < items.length - 1)
                          const Padding(
                            padding: EdgeInsets.only(
                              left: Spacings.spacing50,
                            ),
                            child: Divider(
                              height: .5,
                              thickness: .3,
                            ),
                          )
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
