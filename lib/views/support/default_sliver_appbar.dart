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
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
      toolbarHeight: 50,
      title: Text(
        title.capitalize(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
