import 'package:film_checker/support/string_extension.dart';
import 'package:flutter/material.dart';

class DefaultSliverAppBar extends StatelessWidget {
  final String title;

  const DefaultSliverAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
      toolbarHeight: 50,
      title: Text(
        title.capitalize(),
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: Theme.of(context).appBarTheme.actionsIconTheme!.size,
          color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
        ),
      ),
    );
  }
}
