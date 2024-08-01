import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noting/core/core.dart';

class FolderTile extends StatelessWidget {
  const FolderTile({
    super.key,
    required this.item,
  });

  final ({
    IconData icon,
    String text,
    String count,
    Widget page,
  }) item;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return GestureDetector(
          onTap: () {
            pushTo(context, item.page);
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
              vertical: Spacings.spacing10,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: color.alwaysFFC400,
                ),
                const SizedBox(width: Spacings.spacing10),
                Text(
                  item.text,
                  style: TextStyle(
                    letterSpacing: -.2,
                    color: color.lightBlackDarkWhite,
                  ),
                ),
                const Spacer(),
                Text(
                  item.count,
                  style: TextStyle(
                    color: color.always7F7F7F,
                    fontSize: TextSizes.size16,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -.2,
                  ),
                ),
                const SizedBox(width: Spacings.spacing10),
                Icon(
                  CupertinoIcons.forward,
                  size: 18,
                  color: color.always7F7F7F,
                  weight: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
