import 'package:film_checker/models/review.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewInfoBlock extends StatefulWidget {
  final Review review;

  const ReviewInfoBlock({
    super.key,
    required this.review,
  });

  @override
  State<ReviewInfoBlock> createState() => _ReviewInfoBlockState();
}

class _ReviewInfoBlockState extends State<ReviewInfoBlock> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 25,
        top: 5,
        left: 15,
        right: 15,
      ),
      child: Material(
        color: const Color.fromARGB(255, 51, 51, 51),
        elevation: 15,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .15,
                      child: VerticalDivider(
                        color:
                            widget.review.score < 5 ? Colors.red : Colors.green,
                        width: 5,
                        thickness: 5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                      height: MediaQuery.of(context).size.width * .15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: CustomNetworkImage(
                            path: widget.review.userImagePath),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .43,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.review.nickname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('dd MMMM yyyy')
                                .format(DateTime.parse(widget.review.date))
                                .toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 30,
                            color: Colors.yellow,
                          ),
                          Text(
                            '${widget.review.score}/10',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.review.review,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1,
                    ),
                    maxLines: _isExpanded ? null : 6,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _isExpanded = !_isExpanded;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Text(
                          _isExpanded ? 'read less' : 'read more',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
