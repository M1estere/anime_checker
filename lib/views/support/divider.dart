import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Divider(
            color: Theme.of(context).dividerColor,
            thickness: .5,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
