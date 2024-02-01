import 'package:flutter/material.dart';

class SearchCategoryBlock extends StatelessWidget {
  final String title;

  const SearchCategoryBlock({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Colors.grey.withOpacity(.5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
