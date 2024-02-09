import 'package:film_checker/views/anime_watch_page_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeriesBlock extends StatelessWidget {
  final int index;
  final Map data;

  const SeriesBlock({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AnimeWatchPageView(
                  animeLinks: data['hls'],
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .07,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Episode $index',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Added: ${DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(data['created_timestamp'] * 1000))}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon(
                //   Icons.check_circle_outline_outlined,
                //   size: 35,
                //   color: Colors.grey,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
