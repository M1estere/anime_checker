import 'package:film_checker/models/review.dart';
import 'package:film_checker/views/blocks/info_pages/review_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:film_checker/views/support/scroll_up_button.dart';
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
    super.initState();

    _setupScrollController();
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
        setState(() {
          _showBtn = true;
        });
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange &&
          _showBtn) {
        setState(() {
          _showBtn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBtn
          ? ScrollUpFloatingButton(scrollController: _scrollController)
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const DefaultSliverAppBar(
            title: 'reviews',
          ),
          SliverList.builder(
            itemBuilder: (context, index) => ReviewInfoBlock(
              review: widget.reviews[index],
            ),
            itemCount: widget.reviews.length,
          ),
        ],
      ),
    );
  }
}
