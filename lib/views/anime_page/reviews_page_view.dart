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
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => ReviewInfoBlock(
            review: widget.reviews[index],
          ),
          itemCount: widget.reviews.length,
        ),
      ),
    );
  }
}
