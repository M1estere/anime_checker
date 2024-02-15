import 'package:film_checker/views/blocks/search_page/anilibria_search_category_block.dart';
import 'package:film_checker/views/blocks/search_page/category_block.dart';
import 'package:film_checker/views/pages/search_page/search_results_page_view.dart';
import 'package:flutter/material.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView>
    with AutomaticKeepAliveClientMixin<SearchPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchResultsPageView(),
                  ),
                );
              },
              child: Hero(
                tag: 'searchBox',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      height: 50,
                      child: TextField(
                        enabled: false,
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: Theme.of(context).inputDecorationTheme.border,
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
                            size: 25,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .prefixIconColor,
                          ),
                          hintText: 'Search anime...',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Categories',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SearchCategoryBlock(title: 'Seasons'),
                    SizedBox(
                      width: 10,
                    ),
                    SearchCategoryBlock(title: 'Genres'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                AnilibriaSearchCategoryBlock(title: 'Anilibria Available'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
