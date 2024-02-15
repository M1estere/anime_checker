import 'package:film_checker/views/pages/search_page/anilibria_anime_search_page_view.dart';
import 'package:flutter/material.dart';

class AnilibriaSearchCategoryBlock extends StatelessWidget {
  final String title;

  const AnilibriaSearchCategoryBlock({
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
              return const AnilibriaAnimeSearchPageView();
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Theme.of(context).cardColor,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
