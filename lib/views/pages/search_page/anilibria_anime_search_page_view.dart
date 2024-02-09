import 'package:film_checker/api/anilibria_anime_controller.dart';
import 'package:film_checker/models/anilibria_anime.dart';
import 'package:film_checker/views/blocks/common/anilibria_anime_big_block.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
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
    _setupScrollController();

    _gatherInfo().then((value) {
      _isLoading = false;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
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
        _showBtn = true;
        setState(() {});
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange &&
          _showBtn) {
        _showBtn = false;
        setState(() {});
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
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                    //go to top of scroll
                    0, //scroll offset to go
                    duration:
                        const Duration(milliseconds: 500), //duration of scroll
                    curve: Curves.fastOutSlowIn //scroll type
                    );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            leadingWidth: MediaQuery.of(context).size.width * .9,
            toolbarHeight: 60,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'AniLibria'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          !_isLoading
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
              : SliverFillRemaining(
                  child: _animeList.isNotEmpty
                      ? const Center(
                          child: Text(
                            'Sorry, currently unavailable',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const FetchingCircle(),
                ),
        ],
      ),
    );
  }
}
