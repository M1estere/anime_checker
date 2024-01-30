import 'dart:ui';

import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/anime_page_view.dart';
import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:loop_page_view/loop_page_view.dart';

class ExplorePageView extends StatefulWidget {
  const ExplorePageView({super.key});

  @override
  State<ExplorePageView> createState() => _ExplorePageViewState();
}

class _ExplorePageViewState extends State<ExplorePageView> {
  List<Anime> _randomAnime = [];

  String _bgImage = '';
  Image _currentImage = Image.network('');

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Api().getRandomAnime(10).then((value) {
      _randomAnime = value;

      if (mounted) {
        setState(() {
          _isLoading = false;
          _bgImage = _randomAnime[0].images['jpg']['image_url'];

          _currentImage = Image.network(
            _bgImage,
            fit: BoxFit.fitHeight,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                      child: !_isLoading
                          ? Image.network(
                              _bgImage,
                              fit: BoxFit.fitHeight,
                            )
                          : null,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jujutsu Kaisen',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'Season 1',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey,
                                ),
                                child: const Text(
                                  'Action',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey,
                                ),
                                child: const Text(
                                  'Adventure',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey,
                                ),
                                child: const Text(
                                  'Adult',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '9.0/10',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(500)',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .65,
                    child: SizedBox(
                      child: LoopPageView.builder(
                          onPageChanged: (value) {
                            if (mounted) {
                              setState(() {
                                _bgImage = _randomAnime[value]
                                    .images['jpg']['image_url']
                                    .toString();
                                _currentImage = Image.network(
                                  _bgImage,
                                  fit: BoxFit.fitHeight,
                                );
                              });
                            }
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: _randomAnime.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AnimePageView(
                                      animeImage: _currentImage,
                                      anime: _randomAnime[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Hero(
                                        tag: 'animeImage',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            _randomAnime[index]
                                                .images['jpg']['image_url']
                                                .toString(),
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const Center(
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    _randomAnime[index].libriaId != -1
                                        ? Hero(
                                            tag: 'animeAvailable',
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                              ),
                                            ),
                                          )
                                        : const Center(),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
