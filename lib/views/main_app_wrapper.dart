import 'package:film_checker/views/account_page_view.dart';
import 'package:film_checker/views/explore_page_view.dart';
import 'package:film_checker/views/home_page_view.dart';
import 'package:film_checker/views/search_page_view.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bodies = IndexedStack(
      index: _currentPageIndex,
      children: const [
        ExplorePageView(),
        HomePageView(),
        SearchPageView(),
        AccountPageView(),
      ],
    );

    return Scaffold(
      body: bodies,
    );
  }
}
