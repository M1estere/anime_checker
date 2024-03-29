import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/blocks/anime_page/anime_category_block.dart';
import 'package:film_checker/views/pages/anime_page/anime_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:film_checker/views/support/image_background.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

class ExplorePageView extends StatefulWidget {
  const ExplorePageView({super.key});

  @override
  State<ExplorePageView> createState() => _ExplorePageViewState();
}

class _ExplorePageViewState extends State<ExplorePageView>
    with AutomaticKeepAliveClientMixin<ExplorePageView> {
  @override
  bool get wantKeepAlive => true;

  String _bgImage = '';
  Image _currentImage = Image.network('');

  List<Anime> _anime = [];
  bool _isLoading = true;

  int _currentIndex = 0;

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
    _anime = await Api().getTopAnimeFiltered('bypopularity');

    _bgImage = _anime[0].imagePath;
    _currentImage = Image.network(
      _bgImage,
      fit: BoxFit.cover,
      key: Key(
        _anime[_currentIndex].imagePath,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          !_isLoading
              ? ImageBackground(
                  image: _currentImage,
                  path: _anime[_currentIndex].imagePath,
                )
              : const Center(),
          !_isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _anime[_currentIndex].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      height: 1.1,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _anime[_currentIndex].originalTitle,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                      height: 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                itemCount: _anime[_currentIndex].genres.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    AnimeCategoryBlock(
                                  animeGenre:
                                      _anime[_currentIndex].genres[index],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                    '${_anime[_currentIndex].score}/10',
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
                                    '(${_anime[_currentIndex].scoredBy})',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .65,
                        child: SizedBox(
                          child: LoopPageView.builder(
                              onPageChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    _currentIndex = value;

                                    _bgImage = _anime[_currentIndex].imagePath;
                                    _currentImage = Image.network(
                                      _bgImage,
                                      fit: BoxFit.fitHeight,
                                      key: Key(
                                        _anime[_currentIndex].imagePath,
                                      ),
                                      width: double.infinity,
                                      height: double.infinity,
                                    );
                                  });
                                }
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: _anime.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => AnimePageView(
                                          path: _anime[index].imagePath,
                                          image: _currentImage,
                                          anime: _anime[index],
                                        ),
                                      ),
                                    )
                                        .then((value) {
                                      setState(() {});
                                    });
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
                                            tag:
                                                'animeImage${_anime[index].malId}',
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CustomNetworkImage(
                                                  path: _anime[index].imagePath,
                                                )),
                                          ),
                                        ),
                                        _anime[index].libriaId != -1
                                            ? Hero(
                                                tag:
                                                    'animeAvailable${_anime[index].malId}',
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.play_arrow_rounded,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
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
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Align(
                      alignment: Alignment.center, child: FetchingCircle()),
                ),
        ],
      ),
    );
  }
}
