import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/presentation/components/delete_notes_page_bottom_navigation.dart';

import 'package:noting/app/shared/shared.dart';
import 'package:noting/core/core.dart';

import '../../domain/provider/deleted_note_provider.dart';
import '../components/note_tile.dart';

class DeletedNotesPage extends HookConsumerWidget {
  const DeletedNotesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final notes = ref.watch(deletedNotesProvider);

    return ThemeBuilder(
      bottomNavigationBar: const DeleteNotesPageBottomNavigation(),
      builder: (context, colors, _) {
        return ListViewWithStickyFooter(
          includeAppBar: true,
          title: "Recently Deleted",
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing14,
          ),
          children: [
            CupertinoSearchTextField(
              controller: searchController,
            ),
            const SizedBox(height: Spacings.spacing20),
            Text(
              recentlyInformation,
              style: TextStyle(
                fontSize: TextSizes.size12,
                color: colors.always7F7F7F,
              ),
            ),
            const SizedBox(height: Spacings.spacing20),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: colors.lightFFFFFFDark1C1C1C,
                borderRadius: BorderRadius.circular(
                  Spacings.spacing10,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: notes.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final note = notes[index];
                  final isLastItem = index == notes.length - 1;
                  return Column(
                    children: [
                      NoteTile(
                        note: note,
                        shouldSwipeToRestore: true,
                      ),
                      if (!isLastItem)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacings.spacing16,
                          ),
                          child: Divider(
                            height: .5,
                            thickness: .3,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

const recentlyInformation =
    "Notes are available here for 30 days.After that time, note will be permanently deleted. This may take up to 40 days.";
