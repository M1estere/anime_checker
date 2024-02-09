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
  ScrollController _scrollController = ScrollController();

  List<AnilibriaAnime> _animeList = [];

  bool _isLoading = true;

  @override
  void initState() {
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

  Future _gatherInfo() async {
    _animeList = await AnilibriaAnimeController().getAnilibriaTitles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .9,
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
      body: SafeArea(
        child: !_isLoading
            ? _animeList.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .57,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return AnilibriaAnimeBigBlock(
                                  anime: _animeList[index],
                                );
                              },
                              itemCount: _animeList.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
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
    );
  }
}
