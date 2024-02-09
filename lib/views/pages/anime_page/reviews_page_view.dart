import 'package:film_checker/models/review.dart';
import 'package:film_checker/views/blocks/info_pages/review_block.dart';
import 'package:flutter/material.dart';

class ReviewsPageView extends StatefulWidget {
  final List<Review> reviews;

  const ReviewsPageView({
    super.key,
    required this.reviews,
  });

  @override
  State<ReviewsPageView> createState() => _ReviewsPageViewState();
}

class _ReviewsPageViewState extends State<ReviewsPageView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;

  @override
  void initState() {
    _setupScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  _setupScrollController() {
    _scrollController.addListener(() {
      double showoffset = 10.0;

      if (_scrollController.offset >= showoffset &&
          !_scrollController.position.outOfRange &&
          !_showBtn) {
        _showBtn = true;
        setState(() {});
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange &&
          _showBtn) {
        _showBtn = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBtn
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                    //go to top of scroll
                    0, //scroll offset to go
                    duration:
                        const Duration(milliseconds: 500), //duration of scroll
                    curve: Curves.fastOutSlowIn //scroll type
                    );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            leadingWidth: MediaQuery.of(context).size.width * .9,
            toolbarHeight: 60,
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
                  'reviews'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => ReviewInfoBlock(
              review: widget.reviews[index],
            ),
            itemCount: widget.reviews.length,
          ),
        ],
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   surfaceTintColor: Colors.transparent,
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
      //         'reviews'.toUpperCase(),
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.w500,
      //           fontSize: 25,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // body: SafeArea(
      //   child: ListView.builder(
      //     scrollDirection: Axis.vertical,
      //     itemBuilder: (context, index) => ReviewInfoBlock(
      //       review: widget.reviews[index],
      //     ),
      //     itemCount: widget.reviews.length,
      //   ),
      // ),
    );
  }
}
