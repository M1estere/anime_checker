import 'package:film_checker/api/genres_controller.dart';
import 'package:film_checker/api/seasons_controller.dart';
import 'package:film_checker/views/blocks/common/genre_block.dart';
import 'package:film_checker/views/blocks/common/season_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/scroll_up_button.dart';
import 'package:flutter/material.dart';

class SearchSectionPageView extends StatefulWidget {
  final String title;

  const SearchSectionPageView({
    super.key,
    required this.title,
  });

  @override
  State<SearchSectionPageView> createState() => _SearchSectionPageViewState();
}

class _SearchSectionPageViewState extends State<SearchSectionPageView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;

  List _content = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _setupScrollController();
    if (widget.title.toLowerCase() == 'genres') {
      _gatherInfo(1).then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else if (widget.title.toLowerCase() == 'seasons') {
      _gatherInfo(3).then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future _gatherInfo(int type) async {
    if (type == 1) {
      _content = await GenresController().getAllGenres();
    } else if (type == 3) {
      _content = await SeasonsController().getAllSeasons();
    } else {
      return;
    }
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
          !_scrollController.position.outOfRange &&
          _showBtn) {
        setState(() {
          _showBtn = false;
        });
      }
    });
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
          DefaultSliverAppBar(
            title: widget.title,
          ),
          !_isLoading
              ? SliverList.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Divider(
                        color: Colors.white,
                        thickness: .7,
                        height: 1,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    if (widget.title.toLowerCase() == 'genres') {
                      return GenreBlock(
                        orderNumber: index + 1,
                        genre: _content[index],
                      );
                    } else if (widget.title.toLowerCase() == 'seasons') {
                      return SeasonBlock(season: _content[index]);
                    }
                    return GenreBlock(
                      orderNumber: index + 1,
                      genre: _content[index],
                    );
                  },
                  itemCount: _content.length,
                )
              : const SliverFillRemaining(
                  child: FetchingCircle(),
                ),
        ],
      ),
    );
  }
}
