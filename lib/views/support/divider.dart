import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Divider(
            color: Colors.white,
            thickness: .5,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
