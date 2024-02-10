import 'package:film_checker/views/blocks/series_page/series_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:flutter/material.dart';

class AnimeSeriesListPageView extends StatefulWidget {
  final List data;

  const AnimeSeriesListPageView({
    super.key,
    required this.data,
  });

  @override
  State<AnimeSeriesListPageView> createState() =>
      _AnimeSeriesListPageViewState();
}

class _AnimeSeriesListPageViewState extends State<AnimeSeriesListPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const DefaultSliverAppBar(title: 'series list'),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'AniLibria',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) => SeriesBlock(
                index: index + 1,
                data: widget.data[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
