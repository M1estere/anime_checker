import 'package:flutter/material.dart';

class NoAnimeByRequest extends StatelessWidget {
  const NoAnimeByRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.remove_circle_outline_outlined,
              color: Color(0xFF9D1515),
              size: 80,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                textAlign: TextAlign.center,
                'Sorry, nothing found!',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
