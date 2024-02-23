import 'dart:async';

import 'package:film_checker/api/api.dart';
import 'package:film_checker/api/seasons_controller.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/season.dart';
import 'package:film_checker/views/blocks/home_page/regular_block.dart';
import 'package:film_checker/views/blocks/home_page/wide_block.dart';
import 'package:film_checker/views/pages/anime_by_section_page_view.dart';
import 'package:film_checker/views/pages/anime_page/anime_page_view.dart';
import 'package:film_checker/views/pages/genre_season_anime_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

enum HomeDataType {
  favs,
  seasonal,
  watched,
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin<HomePageView> {
  @override
  bool get wantKeepAlive => true;

  late Timer _timer;
  int _currentTopItem = 0;

  List<Anime> _topBannerAnimeList = [];
  // Anime _topBannerAnime = Anime.createEmpty();

  List<Anime> _favouriteAnime = [];
  List<Anime> _seasonalAnime = [];
  List<Anime> _topWatchedAnime = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentTopItem < _topBannerAnimeList.length - 1) {
        setState(() {
          _currentTopItem++;
        });
      } else {
        setState(() {
          _currentTopItem = 0;
        });
      }
    });

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
    _timer.cancel();

    super.dispose();
  }

  Future _gatherInfo() async {
    _topBannerAnimeList = await Api().getRandomAnime(3);

    _favouriteAnime = await Api().getTopAnimeFiltered('favorite');
    _seasonalAnime = await SeasonsController().getSeasonalAnime(
      1,
      Season.fromJson(
        DateTime.now().year,
        getSeason(DateTime.now()),
      ),
    );
    _topWatchedAnime = await Api().getTopAnimeFiltered('');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: !_isLoading
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .35,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AnimePageView(
                                      path: _topBannerAnimeList[_currentTopItem]
                                          .imagePath,
                                      anime:
                                          _topBannerAnimeList[_currentTopItem],
                                      image: Image.network(
                                        _topBannerAnimeList[_currentTopItem]
                                            .imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: CustomNetworkImage(
                              path: _topBannerAnimeList[_currentTopItem]
                                  .imagePath,
                            ),
                          ),
                          IgnorePointer(
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .35,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomRight,
                                  stops: const [0, .5, .75, 1],
                                  colors: [
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(.1),
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(.5),
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(.8),
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(.95),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      _topBannerAnimeList[_currentTopItem]
                                          .title,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      _topBannerAnimeList[_currentTopItem]
                                          .originalTitle,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _section(
                      'Most Favorited',
                      HomeDataType.favs,
                      _favouriteAnime,
                    ),
                    _section(
                      'Seasonal',
                      HomeDataType.seasonal,
                      _seasonalAnime,
                    ),
                    _section(
                      'Top Watched',
                      HomeDataType.watched,
                      _topWatchedAnime,
                    ),
                  ],
                ),
              )
            : const FetchingCircle(),
      ),
    );
  }

  Widget _section(String title, HomeDataType dataType, List<Anime> data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    if (dataType == HomeDataType.seasonal) {
                      return GenreSeasonAnimePageView(
                        sectionName: 'Seasonal',
                        genreNumber: -1,
                        season: Season.fromJson(
                          DateTime.now().year,
                          getSeason(DateTime.now()),
                        ),
                        type: 1,
                      );
                    }
                    return AnimeSectionPageView(
                      sectionName: title,
                      animeList: data,
                    );
                  },
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'see all',
                    style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              (dataType == HomeDataType.favs ? .225 : .3),
          width: double.infinity,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (dataType == HomeDataType.favs) {
                return WideBlock(
                  anime: data[index],
                );
              }
              return HomeRegularBlock(
                anime: data[index],
              );
            },
            itemCount: (data.length / 2).round(),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
