import 'package:film_checker/api/genres_controller.dart';
import 'package:film_checker/api/seasons_controller.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/pagination.dart';
import 'package:film_checker/models/season.dart';
import 'package:film_checker/views/blocks/common/anime_big_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/scroll_up_button.dart';
import 'package:flutter/material.dart';

class GenreSeasonAnimePageView extends StatefulWidget {
  final String sectionName;
  final int genreNumber;

  final int type;
  final Season season;

  const GenreSeasonAnimePageView({
    super.key,
    required this.sectionName,
    required this.genreNumber,
    required this.type,
    required this.season,
  });

  @override
  State<GenreSeasonAnimePageView> createState() =>
      _GenreSeasonAnimePageViewState();
}

class _GenreSeasonAnimePageViewState extends State<GenreSeasonAnimePageView> {
  final ScrollController _scrollController = ScrollController();

  Pagination _currentPage = Pagination.empty();
  List<Anime> _animeList = [];

  bool _isLoading = true;
  bool _moreLoading = false;

  bool _isBottom = false;
  bool _showBtn = false;

  @override
  void initState() {
    super.initState();

    _setupScrollController();
    _gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  _setupScrollController() {
    _scrollController.addListener(
      () {
        // for floating button
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
            !_scrollController.position.outOfRange &&
            _showBtn) {
          setState(() {
            _showBtn = false;
          });
        }

        // for load more button
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          if (mounted) {
            setState(() {
              _isBottom = true;
            });
          }
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          setState(() {
            _isBottom = false;
          });
        }
      },
    );
  }

  Future _gatherInfo() async {
    if (widget.type == 0) {
      _animeList = await GenresController()
          .getAnimeListByGenre(widget.genreNumber.toString(), 1);

      _currentPage = await GenresController()
          .getCurrentGenrePagination(widget.genreNumber.toString(), 1);
    } else if (widget.type == 1) {
      _animeList = await SeasonsController().getSeasonalAnime(1, widget.season);

      _currentPage = await SeasonsController()
          .getCurrentSeasonPagination(widget.season, 1);
    }
  }

  Future _nextPage() async {
    if (_currentPage.hasNextPage) {
      if (mounted) {
        setState(() {
          _moreLoading = true;
        });
      }

      if (widget.type == 0) {
        _animeList.addAll(
          await GenresController().getAnimeListByGenre(
              widget.genreNumber.toString(), _currentPage.currentPage + 1),
        );
        _currentPage = await GenresController().getCurrentGenrePagination(
            widget.genreNumber.toString(), _currentPage.currentPage + 1);
      } else if (widget.type == 1) {
        _animeList.addAll(await SeasonsController()
            .getSeasonalAnime(_currentPage.currentPage + 1, widget.season));

        _currentPage = await SeasonsController().getCurrentSeasonPagination(
            widget.season, _currentPage.currentPage + 1);
      }

      if (mounted) {
        setState(() {
          _moreLoading = false;
          _isBottom = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBtn
          ? ScrollUpFloatingButton(scrollController: _scrollController)
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DefaultSliverAppBar(title: widget.sectionName),
          !_isLoading
              ? SliverMainAxisGroup(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverGrid.builder(
                        itemCount: _animeList.length,
                        itemBuilder: (context, index) {
                          return AnimeBigBlock(
                            anime: _animeList[index],
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .57,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                      ),
                    ),
                    _isBottom
                        ? _currentPage.hasNextPage
                            ? SliverToBoxAdapter(
                                child: GestureDetector(
                                  onTap: () => _nextPage(),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    color: Colors.grey.withOpacity(.3),
                                    child: Center(
                                      child: !_moreLoading
                                          ? Text(
                                              'Load more'.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : const CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              )
                            : const SliverToBoxAdapter()
                        : const SliverToBoxAdapter(),
                  ],
                )
              : const SliverFillRemaining(
                  child: FetchingCircle(),
                ),
        ],
      ),
    );
  }
}
