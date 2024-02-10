import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/blocks/common/anime_big_block.dart';
import 'package:film_checker/views/support/fetching_circle.dart';
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
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: MySliverPersistentHeaderDelegate(
              widget.sectionName.toUpperCase(),
            ),
          ),
          !_isLoading
              ? SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverGrid.builder(
                    itemCount: widget.animeList.length,
                    itemBuilder: (context, index) {
                      return AnimeBigBlock(
                        anime: widget.animeList[index],
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
              : const SliverFillRemaining(
                  child: FetchingCircle(),
                ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  MySliverPersistentHeaderDelegate(this.title);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: Hero(
        tag: AppBar,
        child: AppBar(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
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
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
