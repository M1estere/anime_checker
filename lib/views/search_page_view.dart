import 'package:film_checker/views/blocks/search_page/category_block.dart';
import 'package:film_checker/views/search_results_page_view.dart';
import 'package:flutter/material.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchResultsPageView(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'searchBox',
                  child: Material(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).snackBarTheme.backgroundColor,
                        border: Border(
                          bottom: Theme.of(context)
                              .inputDecorationTheme
                              .outlineBorder!,
                          top: Theme.of(context)
                              .inputDecorationTheme
                              .outlineBorder!,
                          left: Theme.of(context)
                              .inputDecorationTheme
                              .outlineBorder!,
                          right: Theme.of(context)
                              .inputDecorationTheme
                              .outlineBorder!,
                        ),
                      ),
                      child: SizedBox(
                        height: 60,
                        child: TextField(
                            enabled: false,
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .5,
                            ),
                            decoration: InputDecoration(
                              border:
                                  Theme.of(context).inputDecorationTheme.border,
                              focusedBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusedBorder,
                              enabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder,
                              errorBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .errorBorder,
                              disabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .disabledBorder,
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .prefixIconColor,
                              ),
                              hintText: 'Search anything...',
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                            ),
                            onChanged: (value) {}),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    SearchCategoryBlock(title: 'Rated Most'),
                    SizedBox(
                      width: 10,
                    ),
                    SearchCategoryBlock(title: 'Genres'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    SearchCategoryBlock(title: 'Available to Watch'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
