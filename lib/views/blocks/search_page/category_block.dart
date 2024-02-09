import 'package:film_checker/views/pages/search_page/search_section_page_view.dart';
import 'package:flutter/material.dart';

class SearchCategoryBlock extends StatelessWidget {
  final String title;

  const SearchCategoryBlock({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SearchSectionPageView(
                title: title,
              );
            },
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}
