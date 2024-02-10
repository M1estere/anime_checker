import 'package:film_checker/api/anime_controller.dart';
import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anilibria_anime.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/character.dart';
import 'package:film_checker/models/picture.dart';
import 'package:film_checker/models/review.dart';
import 'package:film_checker/models/video.dart';
import 'package:film_checker/views/blocks/anime_page/anime_category_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_character_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_picture_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_review_block.dart';
import 'package:film_checker/views/blocks/anime_page/anime_video_block.dart';
import 'package:film_checker/views/pages/anime_page/anime_series_list_page_view.dart';
import 'package:film_checker/views/pages/anime_page/characters_page_view.dart';
import 'package:film_checker/views/pages/anime_page/fullscreen_gallery_page_view.dart';
import 'package:film_checker/views/pages/anime_page/reviews_page_view.dart';
import 'package:film_checker/views/support/divider.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/image_background.dart';
import 'package:flutter/material.dart';

enum DataType {
  characters,
  videos,
  reviews,
  pictures,
}

class AnimePageView extends StatefulWidget {
  final AnimeParent anime;

  final Image image;
  final String path;

  const AnimePageView({
    super.key,
    required this.anime,
    required this.image,
    required this.path,
  });

  @override
  State<AnimePageView> createState() => _AnimePageViewState();
}

class _AnimePageViewState extends State<AnimePageView> {
  List<Character> _characters = [];
  List<Review> _reviews = [];
  List<Video> _videos = [];
  List<Picture> _pictures = [];

  bool _isLoading = true;

  bool _maxLinesExpanded = false;

  @override
  void initState() {
    super.initState();

    _gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future _gatherInfo() async {
    if (widget.anime.malId == -1) {
      await AnimeController().setupAnimeFields(widget.anime as AnilibriaAnime);
    }

    _characters = await AnimeController().getCharacters(widget.anime.malId);
    await Future.delayed(const Duration(milliseconds: 500));

    _reviews = await AnimeController().getReviews(widget.anime.malId);

    _videos = await AnimeController().getVideos(widget.anime.malId);
    await Future.delayed(const Duration(milliseconds: 500));

    _pictures = await AnimeController().getPictures(widget.anime.malId);

    if (widget.anime.checkedLibria == false) {
      (int, List) t = (await Api().getLibriaCode(widget.anime.title));

      widget.anime.libriaId = t.$1;
      widget.anime.series = t.$2;

      widget.anime.checkedLibria = true;
    }
  }

  _reloadPage() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    _gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Hero(
          tag: AppBar,
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leadingWidth: 71, // 56
            toolbarHeight: 50,
            leading: UnconstrainedBox(
              child: SizedBox(
                width: 45,
                height: 45,
                child: ElevatedButton(
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
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: widget.anime.libriaId != -1
          ? FloatingActionButton(
              heroTag:
                  'animeAvailable${widget.anime.malId != -1 ? widget.anime.malId : widget.anime.libriaId}',
              splashColor: Colors.blue.withOpacity(.3),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AnimeSeriesListPageView(
                        data: widget.anime.series!,
                      );
                    },
                  ),
                );
              },
              backgroundColor: Colors.blue,
              elevation: 15,
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 45,
                color: Colors.white,
              ),
            )
          : null,
      body: Stack(
        children: [
          ImageBackground(
            image: widget.image,
            path: widget.path,
          ),
          SizedBox(
            child: Stack(
              children: [
                RefreshIndicator(
                  edgeOffset: MediaQuery.of(context).size.height * .3,
                  onRefresh: () => _reloadPage(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .315,
                        ),
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.anime.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        '${widget.anime.originalTitle} ${widget.anime.malId == -1 ? '' : widget.anime.malId}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          height: 1,
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
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
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
                                !_isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 25,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${widget.anime.score}/10',
                                              style: const TextStyle(
                                                fontSize: 15,
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
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Center(),
                              ],
                            ),
                            !_isLoading
                                ? const CustomDivider()
                                : const Center(),
                            !_isLoading
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              fontSize: 15,
                                              height: 1.35,
                                            ),
                                            overflow: _maxLinesExpanded
                                                ? TextOverflow.visible
                                                : TextOverflow.ellipsis,
                                            maxLines:
                                                _maxLinesExpanded ? null : 5,
                                          ),
                                          widget.anime.synopsis.length > 314
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const Center(),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(),
                            SizedBox(
                              height: _characters.isNotEmpty ? 10 : 0,
                            ),
                            !_isLoading
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.anime.status} | ${widget.anime.type} | ${widget.anime.episodes} ep${widget.anime.midDuration}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(),
                            !_isLoading
                                ? Column(
                                    children: [
                                      _section(
                                        'Characters',
                                        DataType.characters,
                                        _characters,
                                        MediaQuery.of(context).size.height *
                                            .18,
                                      ),
                                      _section(
                                        'Videos',
                                        DataType.videos,
                                        _videos,
                                        MediaQuery.of(context).size.height *
                                            .21,
                                      ),
                                      _section(
                                        'Reviews',
                                        DataType.reviews,
                                        _reviews,
                                        MediaQuery.of(context).size.height *
                                            .223,
                                      ),
                                      _section(
                                        'Gallery',
                                        DataType.pictures,
                                        _pictures,
                                        MediaQuery.of(context).size.height * .4,
                                      ),
                                      SizedBox(
                                        height: _pictures.isNotEmpty ? 15 : 0,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .6,
                                    child: const FetchingCircle(),
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Hero(
                      tag:
                          'animeImage${(widget.anime.malId != -1 ? widget.anime.malId : widget.anime.libriaId)}',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return FullScreenGalleryPageView(
                                  currentIndex: 0,
                                  imagePaths: [widget.path],
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .3,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            image: DecorationImage(
                              image: widget.image.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, DataType dataType, List data, double height) {
    return Column(
      children: [
        data.isNotEmpty ? const CustomDivider() : const Center(),
        data.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          if (dataType == DataType.pictures ||
                              dataType == DataType.videos) {
                            return;
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                if (dataType == DataType.characters) {
                                  return CharactersPageView(
                                      characters: _characters);
                                } else if (dataType == DataType.reviews) {
                                  return ReviewsPageView(
                                    reviews: _reviews,
                                  );
                                }
                                return CharactersPageView(
                                    characters: _characters);
                              },
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (dataType != DataType.pictures &&
                                      dataType != DataType.videos)
                                  ? Text(
                                      data.length > 5 ? 'see all' : '',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : const Center(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        itemBuilder: (context, index) {
                          if (dataType == DataType.characters) {
                            return AnimeCharacterBlock(character: data[index]);
                          } else if (dataType == DataType.reviews) {
                            return AnimeReviewBlock(review: data[index]);
                          } else if (dataType == DataType.videos) {
                            return AnimeVideoBlock(video: data[index]);
                          } else if (dataType == DataType.pictures) {
                            return AnimePictureBlock(
                              imageIndex: index,
                              imagePaths: [for (var obj in data) obj.path],
                            );
                          }
                          return const Center();
                        },
                        itemCount: data.length > 5 ? 5 : data.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              )
            : const Center(),
      ],
    );
  }
}
