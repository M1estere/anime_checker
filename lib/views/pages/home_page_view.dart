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

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin<HomePageView> {
  @override
  bool get wantKeepAlive => true;

  Anime _topBannerAnime = Anime.createEmpty();
  List<Anime> _favouriteAnime = [];
  List<Anime> _seasonalAnime = [];
  List<Anime> _topWatchedAnime = [];

  bool _isLoading = true;

  @override
  void initState() {
    gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    super.initState();
  }

  Future gatherInfo() async {
    _topBannerAnime = (await Api().getRandomAnime(1))[0];

    _favouriteAnime = await Api().getTopAnimeFiltered('favorite');
    _seasonalAnime = await SeasonsController()
        .getSeasonalAnime(1, Season.fromJson(2024, 'winter'));
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AnimePageView(
                                path: _topBannerAnime.images['jpg']
                                    ['large_image_url'],
                                anime: _topBannerAnime,
                                animeImage: Image.network(
                                  _topBannerAnime.images['jpg']
                                      ['large_image_url'],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .35,
                            child: CustomNetworkImage(
                                path: _topBannerAnime.images['jpg']
                                    ['large_image_url']),
                          ),
                          Container(
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
                                    _topBannerAnime.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _topBannerAnime.originalTitle,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AnimeSectionPageView(
                                  sectionName: 'Most Favorited',
                                  animeList: _favouriteAnime,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Most Favorited',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'see all',
                                style: TextStyle(
                                  color: Color(0xFF00A3FF),
                                  fontSize: 17,
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
                      height: MediaQuery.of(context).size.height * .225,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return WideBlock(
                            anime: _favouriteAnime[index],
                          );
                        },
                        itemCount: (_favouriteAnime.length / 2).round(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return GenreSeasonAnimePageView(
                                  sectionName: 'Seasonal',
                                  genreNumber: -1,
                                  season: Season.fromJson(2024, 'winter'),
                                  type: 1,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Seasonal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'see all',
                                style: TextStyle(
                                  color: Color(0xFF00A3FF),
                                  fontSize: 17,
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
                      height: MediaQuery.of(context).size.height * .3,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HomeRegularBlock(
                            anime: _seasonalAnime[index],
                          );
                        },
                        itemCount: (_seasonalAnime.length / 2).round(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AnimeSectionPageView(
                                  sectionName: 'Top Watched',
                                  animeList: _topWatchedAnime,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Top Watched',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'see all',
                                style: TextStyle(
                                  color: Color(0xFF00A3FF),
                                  fontSize: 17,
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
                      height: MediaQuery.of(context).size.height * .3,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HomeRegularBlock(
                            anime: _topWatchedAnime[index],
                          );
                        },
                        itemCount: (_topWatchedAnime.length / 2).round(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            : const FetchingCircle(),
      ),
    );
  }
}