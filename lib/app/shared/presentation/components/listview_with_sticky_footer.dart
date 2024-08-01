import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noting/core/core.dart';

class ListViewWithStickyFooter extends StatelessWidget {
  final List<Widget> children;
  final List<Widget>? stickyFooterChildren;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final bool includeAppBar;
  final String title;

  const ListViewWithStickyFooter({
    super.key,
    required this.children,
    this.padding,
    this.alignment,
    this.stickyFooterChildren,
    this.includeAppBar = false,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return CustomScrollView(
          slivers: <Widget>[
            if (includeAppBar)
              CupertinoSliverNavigationBar(
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.ellipsis_circle,
                    size: Spacings.spacing26,
                    weight: Spacings.spacing6,
                    color: color.alwaysFFC400,
                  ),
                ),
                padding: EdgeInsetsDirectional.zero,
                leading: canPop(context)
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (canPop(context)) {
                            pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: Spacings.spacing26,
                          weight: Spacings.spacing6,
                          color: color.alwaysFFC400,
                        ),
                      )
                    : null,
                largeTitle: Text(
                  title,
                  style: TextStyle(
                    color: color.lightBlackDarkWhite,
                  ),
                ),
                backgroundColor: color.lightF9F9F9Dark000000,
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: padding ?? const EdgeInsets.all(0),
                    child: Align(
                      alignment: alignment ?? Alignment.center,
                      child: children[index],
                    ),
                  );
                },
                childCount: children.length,
              ),
            ),
            if (stickyFooterChildren != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: stickyFooterChildren!,
                ),
              ),
          ],
        );
      },
    );
  }
}
