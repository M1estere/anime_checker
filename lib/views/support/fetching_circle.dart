import 'package:flutter/material.dart';

class FetchingCircle extends StatelessWidget {
  const FetchingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Fetching info...',
            style: TextStyle(
              color: Colors.white,
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
