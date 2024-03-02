import 'dart:async';

import 'package:extended_wrap/extended_wrap.dart';
import 'package:film_checker/api/genres_controller.dart';
import 'package:film_checker/api/search_controller.dart' as search;
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/genre.dart';
import 'package:film_checker/models/pagination.dart';
import 'package:film_checker/support/string_extension.dart';
import 'package:film_checker/views/blocks/search_page/search_page_category_block.dart';
import 'package:film_checker/views/blocks/search_page/search_result_block.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/scroll_up_button.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:stream_transform/stream_transform.dart';

class SearchResultsPageView extends StatefulWidget {
  const SearchResultsPageView({super.key});

  @override
  State<SearchResultsPageView> createState() => _SearchResultsPageViewState();
}

class _SearchResultsPageViewState extends State<SearchResultsPageView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;

  final StreamController _streamcontroller = StreamController();
  final PanelController _panelController = PanelController();
  final TextEditingController _searchController = TextEditingController();

  List<Anime> _resultAnime = [];
  Pagination _currentPage = Pagination.empty();

  bool __allGenresDisplayed = false;

  List<Genre> _allGenres = [];
  final List<Genre> _activeGenres = [];
  final List<Genre> _excludedGenres = [];

  bool _loadingResults = false;
  bool _loadingGenres = true;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();

    _setupScrollController();
    _gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _loadingGenres = false;
        });
      }
    });

    _streamcontroller.stream
        .debounce(const Duration(milliseconds: 500))
        .listen((event) {
      _updatePage();
    });
  }

  _setupScrollController() {
    _scrollController.addListener(() {
      double showoffset = 10.0;

      if (_scrollController.offset >= showoffset &&
          !_scrollController.position.outOfRange &&
          !_showBtn) {
        setState(() {
          _showBtn = true;
        });
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _showBtn = false;
        });
      }
    });
  }

  Future _gatherInfo() async {
    _allGenres = await GenresController().getAllGenres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  _updatePage() {
    _performSearch().then((value) {
      _loadingResults = false;
      setState(() {});
    });
  }

  Future _nextPage() async {
    if (_currentPage.hasNextPage) {
      if (mounted) {
        setState(() {
          _loadingMore = true;
        });
      }

      (List<Anime>, Pagination) t = await search.SearchController()
          .getAnimeBySearch(
              [for (var obj in _activeGenres) obj.id.toString()],
              [for (var obj in _excludedGenres) obj.id.toString()],
              _searchController.text,
              _currentPage.currentPage + 1);

      _resultAnime.addAll(t.$1);
      _currentPage = t.$2;

      if (mounted) {
        setState(() {
          _loadingMore = false;
        });
      }
    }
  }

  Future _performSearch() async {
    if (mounted) {
      setState(() {
        _loadingResults = true;
      });
    }
    (List<Anime>, Pagination) t = await search.SearchController()
        .getAnimeBySearch(
            [for (var obj in _activeGenres) obj.id.toString()],
            [for (var obj in _excludedGenres) obj.id.toString()],
            _searchController.text,
            1);

    _resultAnime = t.$1;
    _currentPage = t.$2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBtn
          ? ScrollUpFloatingButton(scrollController: _scrollController)
          : null,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              return _updatePage();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
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
                              onChanged: (value) {
                                _streamcontroller.add(value);
                              },
                              onSubmitted: (value) {
                                _updatePage();
                              },
                              onEditingComplete: () {
                                _updatePage();
                              },
                              autofocus: true,
                              controller: _searchController,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                              decoration: InputDecoration(
                                border: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
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
                                    size: 25,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .prefixIconColor,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                hintText: 'Search anime',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                                suffixIcon: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  width: 100,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const VerticalDivider(
                                          color: Colors.white,
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: .5,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (_panelController.isPanelOpen) {
                                              _panelController.close();
                                            } else {
                                              _panelController.open();
                                            }
                                            FocusScope.of(context).unfocus();
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.filter_alt_rounded,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .13,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _searchController.text,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 25,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _activeGenres.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey
                                                    .withOpacity(.5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1.5,
                                                      horizontal: 4),
                                              child: Text(
                                                _activeGenres[index].name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 25,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _excludedGenres.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey
                                                    .withOpacity(.5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1.5,
                                                      horizontal: 4),
                                              child: Text(
                                                _excludedGenres[index].name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // const FetchingCircle(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: !_loadingResults
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _resultAnime.isNotEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Found anime'.capitalize(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          Text(
                                            '${_currentPage.wholeAmount}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Center(),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 5),
                                  itemBuilder: (context, index) {
                                    return SearchResultBlock(
                                      anime: _resultAnime[index],
                                    );
                                  },
                                  itemCount: _resultAnime.length,
                                ),
                                _currentPage.hasNextPage
                                    ? GestureDetector(
                                        onTap: () => _nextPage(),
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          color: Colors.grey.withOpacity(.3),
                                          child: Center(
                                            child: !_loadingMore
                                                ? Text(
                                                    'Load more'.toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : const CircularProgressIndicator(),
                                          ),
                                        ),
                                      )
                                    : const Center(),
                              ],
                            )
                          : const FetchingCircle(),
                    )
                  ],
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            backdropTapClosesPanel: true,
            isDraggable: false,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            backdropEnabled: true,
            color: const Color.fromARGB(255, 31, 31, 31),
            controller: _panelController,
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * .65,
            panelBuilder: () {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filters'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _panelController.close();
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Genres'.toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            !_loadingGenres
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ExtendedWrap(
                                          maxLines:
                                              __allGenresDisplayed ? 50 : 3,
                                          minLines:
                                              __allGenresDisplayed ? 50 : 3,
                                          alignment: WrapAlignment.start,
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              _allGenres.length, (index) {
                                            return SearchPageCategoryBlock(
                                              genre: _allGenres[index],
                                              included: _activeGenres,
                                              excluded: _excludedGenres,
                                              updateFunc: _updatePage,
                                            );
                                          }),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            __allGenresDisplayed =
                                                !__allGenresDisplayed;
                                          });
                                        },
                                        child: Text(
                                          __allGenresDisplayed
                                              ? 'Collapse'
                                              : 'Expand',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const FetchingCircle(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
