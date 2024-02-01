import 'package:film_checker/models/review.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewInfoBlock extends StatelessWidget {
  final Review review;

  const ReviewInfoBlock({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 25,
        top: 5,
        left: 10,
        right: 10,
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
                        color: review.score < 5 ? Colors.red : Colors.green,
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
                        child: Image.network(
                          review.userImagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.nickname,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy')
                              .format(DateTime.parse(review.date))
                              .toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
                            '${review.score}/10',
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
                    review.review,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
