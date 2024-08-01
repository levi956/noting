import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noting/core/core.dart';

class NotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotesAppBar({
    super.key,
    this.leading,
    this.actions,
    required this.onPopContext,
  });

  final Widget? leading;
  final Widget? actions;

  final VoidCallback onPopContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ThemeBuilder(
        useScaffold: false,
        builder: (_, color, ref) {
          return AppBar(
            backgroundColor: color.lightF9F9F9Dark000000,
            titleSpacing: -5,
            leadingWidth: Spacings.spacing40,
            centerTitle: false,
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                CupertinoIcons.back,
                color: color.alwaysFFC400,
                size: Spacings.spacing30,
              ),
              onPressed: onPopContext,
            ),
            title: GestureDetector(
              onTap: onPopContext,
              child: Text(
                "Notes",
                style: TextStyle(
                  color: color.alwaysFFC400,
                  fontSize: TextSizes.size18,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.share,
                  color: color.alwaysFFC400,
                  size: Spacings.spacing26,
                ),
                onPressed: () {},
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.ellipsis_circle,
                  size: Spacings.spacing26,
                  weight: Spacings.spacing6,
                  color: color.alwaysFFC400,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Spacings.spacing40);
}
