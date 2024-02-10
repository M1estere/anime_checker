import 'package:flutter/material.dart';

class ScrollUpFloatingButton extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollUpFloatingButton({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      },
      child: const Icon(Icons.arrow_upward),
    );
  }
}
