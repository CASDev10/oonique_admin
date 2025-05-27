import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../config/routes/nav_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppbar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.bottom,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.primary,
      title:
          title != null && title.toString().isNotEmpty
              ? Text(title.toString())
              : SvgPicture.asset("assets/images/svg/ic_todo_logo.svg"),
      automaticallyImplyLeading: false,
      leading:
          Navigator.of(context).canPop()
              ? IconButton(
                onPressed: () {
                  NavRouter.pop(context);
                },
                icon: SvgPicture.asset('assets/images/svg/ic_back.svg'),
              )
              : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
