import 'package:film_checker/views/support/fetching_circle.dart';
import 'package:flutter/material.dart';

class AnimeWatchPageView extends StatefulWidget {
  final String animeLink;

  const AnimeWatchPageView({
    super.key,
    required this.animeLink,
  });

  @override
  State<AnimeWatchPageView> createState() => _AnimeWatchPageViewState();
}

class _AnimeWatchPageViewState extends State<AnimeWatchPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: const FetchingCircle(),
    );
  }
}
