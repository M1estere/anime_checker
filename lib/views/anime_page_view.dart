import 'dart:ui';

import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/character.dart';
import 'package:film_checker/models/review.dart';
import 'package:film_checker/models/video.dart';
import 'package:film_checker/views/blocks/anime_page/anime_category_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_character_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_review_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_video_block.dart';
import 'package:film_checker/views/characters_page_view.dart';
import 'package:film_checker/views/reviews_page_view.dart';
import 'package:film_checker/views/support/divider.dart';
import 'package:film_checker/views/support/image_background.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:flutter/material.dart';

class AnimePageView extends StatefulWidget {
  final Image animeImage;
  final Anime anime;

  const AnimePageView({
    super.key,
    required this.anime,
    required this.animeImage,
  });

  @override
  State<AnimePageView> createState() => _AnimePageViewState();
}

class _AnimePageViewState extends State<AnimePageView> {
  List<Character> _characters = [];
  List<Review> _reviews = [];
  List<Video> _videos = [];

  bool _isLoading = true;

  bool _maxLinesExpanded = false;

  @override
  void initState() {
    super.initState();

    Api().getCharacters(widget.anime.malId).then((value) {
      if (mounted) {
        setState(() {
          _characters = value;
        });

        Api().getReviews(widget.anime.malId).then((value) {
          if (mounted) {
            setState(() {
              _reviews = value;
            });

            Api().getVideos(widget.anime.malId).then((value) {
              if (mounted) {
                setState(() {
                  _videos = value;

                  _isLoading = false;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 71, // 56
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.only(right: 0),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 32,
          ),
        ),
      ),
      body: Stack(
        children: [
          ImageBackground(image: widget.animeImage),
          SizedBox(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.anime.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        height: 1.2,
                                      ),
                                    ),
                                    Text(
                                      '${widget.anime.originalTitle} ${widget.anime.malId}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        height: 1.2,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(left: 15),
                                  itemCount: widget.anime.genres.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      AnimeCategoryBlock(
                                    animeGenre: widget.anime.genres[index],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.anime.score}/10',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '(${widget.anime.scoredBy})',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const CustomDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'About the anime',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.anime.synopsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                    overflow: _maxLinesExpanded
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                    maxLines: _maxLinesExpanded ? null : 5,
                                  ),
                                  widget.anime.synopsis.length > 292
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (mounted) {
                                                  setState(() {
                                                    _maxLinesExpanded =
                                                        !_maxLinesExpanded;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _maxLinesExpanded
                                                    ? 'read less'
                                                    : 'read more',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Center(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          !_isLoading
                              ? Column(
                                  children: [
                                    _characters.isNotEmpty
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .175,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Characters',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return CharactersPageView(
                                                                    characters:
                                                                        _characters);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          _characters.length > 5
                                                              ? 'see all'
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF00A3FF),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            AnimeCharacterBlock(
                                                      character:
                                                          _characters[index],
                                                    ),
                                                    itemCount:
                                                        _characters.length > 5
                                                            ? 5
                                                            : _characters
                                                                .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const Center(),
                                    _videos.isNotEmpty
                                        ? const CustomDivider()
                                        : const Center(),
                                    _videos.isNotEmpty
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .21,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    'Videos',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: _videos.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            AnimeVideoBlock(
                                                      video: _videos[index],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const Center(),
                                    _reviews.isNotEmpty
                                        ? const CustomDivider()
                                        : const Center(),
                                    _reviews.isNotEmpty
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .21,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Reviews',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return ReviewsPageView(
                                                                  reviews:
                                                                      _reviews,
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'see all',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF00A3FF),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        _reviews.length > 5
                                                            ? 5
                                                            : _reviews.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            AnimeReviewBlock(
                                                      review: _reviews[index],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const Center(),
                                    SizedBox(
                                      height: _reviews.isNotEmpty ? 15 : 0,
                                    ),
                                  ],
                                )
                              : const FetchingCircle(),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Hero(
                      tag: 'animeImage${widget.anime.malId}',
                      child: Container(
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          image: DecorationImage(
                            image: widget.animeImage.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    widget.anime.libriaId != -1
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Hero(
                              tag: 'animeAvailable${widget.anime.malId}',
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
