import 'package:film_checker/views/support/no_anime_by_request.dart';
import 'package:flutter/material.dart';

class SearchResultsPageView extends StatefulWidget {
  const SearchResultsPageView({super.key});

  @override
  State<SearchResultsPageView> createState() => _SearchResultsPageViewState();
}

class _SearchResultsPageViewState extends State<SearchResultsPageView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: 'searchBox',
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        bottom: const BorderSide(
                          color: Colors.grey,
                        ),
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
                        autofocus: true,
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .5,
                        ),
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
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .prefixIconColor,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          hintText: 'Search anything...',
                          hintStyle:
                              Theme.of(context).inputDecorationTheme.hintStyle,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 30,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              (_searchController.text.isNotEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Results'.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * .7,
                        //   child: ListView.builder(
                        //     itemCount: _searchResults.length,
                        //     scrollDirection: Axis.vertical,
                        //     itemBuilder: (context, index) {
                        //       return FullMangaBlock(
                        //         title: _searchResults[index].title!,
                        //         chapters: _searchResults[index].chapters!,
                        //         status: _searchResults[index].status!,
                        //         author: _searchResults[index].author!,
                        //         image: _searchResults[index].image!,
                        //         desc: _searchResults[index].desc!,
                        //         rates: _searchResults[index].rates!,
                        //         ratings: _searchResults[index].ratings!,
                        //         releaseYear: _searchResults[index].year!,
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    )
                  : const NoAnimeByRequest()
              // : SizedBox(
              //     height: MediaQuery.of(context).size.height * .75,
              //     child: Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           const Icon(
              //             Icons.article_outlined,
              //             color: Colors.green,
              //             size: 80,
              //           ),
              //           const SizedBox(
              //             height: 5,
              //           ),
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width * .8,
              //             child: Text(
              //               textAlign: TextAlign.center,
              //               'Type something to find!',
              //               style: TextStyle(
              //                 color: Theme.of(context).primaryColor,
              //                 fontSize: 25,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
