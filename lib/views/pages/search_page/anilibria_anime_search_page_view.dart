import 'package:film_checker/api/anilibria_anime_controller.dart';
import 'package:film_checker/models/anilibria_anime.dart';
import 'package:film_checker/views/blocks/common/anilibria_anime_big_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/scroll_up_button.dart';
import 'package:flutter/material.dart';

class AnilibriaAnimeSearchPageView extends StatefulWidget {
  const AnilibriaAnimeSearchPageView({super.key});

  @override
  State<AnilibriaAnimeSearchPageView> createState() =>
      _AnilibriaAnimeSearchPageViewState();
}

class _AnilibriaAnimeSearchPageViewState
    extends State<AnilibriaAnimeSearchPageView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;

  List<AnilibriaAnime> _animeList = [];
  bool _isLoading = true;

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

  Future _gatherInfo() async {
    _animeList = await AnilibriaAnimeController().getAnilibriaTitles();
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
          const DefaultSliverAppBar(title: 'AniLibria'),
          !_isLoading
              ? _animeList.isNotEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverGrid.builder(
                        itemCount: _animeList.length,
                        itemBuilder: (context, index) {
                          return AnilibriaAnimeBigBlock(
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
                    )
                  : const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Sorry, service currently unavailable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
              : const SliverFillRemaining(
                  child: FetchingCircle(),
                ),
        ],
      ),
    );
  }
}
