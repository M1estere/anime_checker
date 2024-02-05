import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/blocks/anime_big_block.dart';
import 'package:flutter/material.dart';

class AnimeSectionPageView extends StatefulWidget {
  final String sectionName;
  final List<Anime> animeList;

  const AnimeSectionPageView({
    super.key,
    required this.sectionName,
    required this.animeList,
  });

  @override
  State<AnimeSectionPageView> createState() => _AnimeSectionPageViewState();
}

class _AnimeSectionPageViewState extends State<AnimeSectionPageView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    gatherInfo().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future gatherInfo() async {
    await Future.delayed(const Duration(milliseconds: 300));
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
              widget.sectionName.toUpperCase(),
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
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .57,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return AnimeBigBlock(
                        anime: widget.animeList[index],
                      );
                    },
                    itemCount: widget.animeList.length,
                  ),
                ),
              )
            : const Center(),
      ),
    );
  }
}
