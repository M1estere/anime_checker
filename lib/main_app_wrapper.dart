import 'package:film_checker/views/pages/account_page_view.dart';
import 'package:film_checker/views/pages/explore_page_view.dart';
import 'package:film_checker/views/pages/home_page_view.dart';
import 'package:film_checker/views/pages/search_page/search_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

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
    super.initState();

    _currentPageIndex = 0;
    _pages = const [
      ExplorePageView(),
      HomePageView(),
      SearchPageView(),
      AccountPageView(),
    ];

    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Hero(
          tag: AppBar,
          child: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      primary: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        snakeViewColor: Colors.blue,
        height: 50,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPageIndex,
        onTap: (value) {
          setState(() {
            _currentPageIndex = value;
            _pageController.jumpToPage(_currentPageIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
            ),
            activeIcon: Icon(
              Icons.explore,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            activeIcon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            activeIcon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
