import 'package:flutter/material.dart';

class FetchingCircle extends StatelessWidget {
  const FetchingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Fetching info...',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
