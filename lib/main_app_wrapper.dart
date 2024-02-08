import 'package:film_checker/views/account_page_view.dart';
import 'package:film_checker/views/explore_page_view.dart';
import 'package:film_checker/views/home_page_view.dart';
import 'package:film_checker/views/search_page_view.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  PageController _pageController = PageController();
  List<Widget> _pages = [];

  int _currentPageIndex = 0;

  @override
  void initState() {
    _currentPageIndex = 0;
    _pages = [
      ExplorePageView(),
      HomePageView(),
      SearchPageView(),
      AccountPageView(),
    ];

    _pageController = PageController(initialPage: _currentPageIndex);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      primary: true,
      bottomNavigationBar: StylishBottomBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.jumpToPage(_currentPageIndex);
          });
        },
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        option: AnimatedBarOptions(
          iconSize: 30,
          barAnimation: BarAnimation.liquid,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.explore_outlined),
            title: Text(
              'Explore',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.explore),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
          BottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: Text(
              'Home',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.home),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: Text(
              'Search',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.search),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: Text(
              'Account',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.person),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
        ],
      ),
    );
  }
}
