import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:noting/app/modules/notes/domain/provider/note_provider.dart';

import 'package:noting/app/shared/shared.dart';
import 'package:noting/core/core.dart';

import '../components/note_tile.dart';
import '../components/notes_page_bottom_navigation.dart';

class NotesPage extends HookConsumerWidget {
  const NotesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final notes = ref.watch(noteProvider);

    return ThemeBuilder(
      bottomNavigationBar: const NotesPageBottomNavigation(),
      builder: (context, colors, _) {
        return ListViewWithStickyFooter(
          includeAppBar: true,
          title: "Notes",
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing14,
          ),
          children: [
            CupertinoSearchTextField(
              controller: searchController,
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

extension Enumerate<T> on List<T> {
  List<(int, T)> enumerate() {
    return List.generate(length, (index) => (index, this[index]));
  }
}
