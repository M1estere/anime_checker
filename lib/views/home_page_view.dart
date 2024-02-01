import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/anime_by_section_page_view.dart';
import 'package:film_checker/views/anime_page_view.dart';
import 'package:film_checker/views/blocks/home_page/regular_block.dart';
import 'package:film_checker/views/blocks/home_page/wide_block.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<Anime> _randomAnime = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Api().getRandomAnime(10).then((value) {
      if (mounted) {
        setState(() {
          _randomAnime = value;

          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                anime: _randomAnime[0],
                                animeImage: Image.network(
                                  _randomAnime[0].images['jpg']
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
                            child: Image.network(
                              _randomAnime[0].images['jpg']['large_image_url'],
                              fit: BoxFit.cover,
                            ),
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
                                    _randomAnime[0].title,
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
                                    _randomAnime[0].originalTitle,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Trending',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AnimeSectionPageView(
                                      sectionName: 'Trending',
                                      animeList: _randomAnime,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'see all',
                              style: TextStyle(
                                color: Color(0xFF00A3FF),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .22,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return WideBlock(
                            anime: _randomAnime[index],
                          );
                        },
                        itemCount: (_randomAnime.length / 2).round(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Most Popular',
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
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .29,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HomeRegularBlock(
                            anime: _randomAnime[index],
                          );
                        },
                        itemCount: (_randomAnime.length / 2).round(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hottest',
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
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .29,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HomeRegularBlock(
                            anime: _randomAnime[index],
                          );
                        },
                        itemCount: (_randomAnime.length / 2).round(),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
            : const Center(),
      ),
    );
  }
}
