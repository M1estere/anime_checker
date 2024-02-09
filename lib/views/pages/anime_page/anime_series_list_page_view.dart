import 'package:film_checker/views/blocks/series_page/series_block.dart';
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
      // appBar: AppBar(
      //   leadingWidth: MediaQuery.of(context).size.width * .9,
      //   leading: Row(
      //     children: [
      //       IconButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         icon: const Icon(
      //           Icons.arrow_back_ios_new,
      //           size: 35,
      //           color: Colors.white,
      //         ),
      //       ),
      //       Text(
      //         'series list'.toUpperCase(),
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.w500,
      //           fontSize: 25,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            floating: true,
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
                  'series list'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
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
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           const Text(
      //             'AniLibria',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 25,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           Column(
      //             children: List.generate(widget.data.length, (index) {
      //               return SeriesBlock(
      //                 index: index + 1,
      //                 data: widget.data[index],
      //               );
      //             }),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
