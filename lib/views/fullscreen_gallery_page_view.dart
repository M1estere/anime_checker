import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenGalleryPageView extends StatefulWidget {
  final List<String> imagePaths;
  final int currentIndex;

  const FullScreenGalleryPageView({
    super.key,
    required this.currentIndex,
    required this.imagePaths,
  });

  @override
  State<FullScreenGalleryPageView> createState() =>
      _FullScreenGalleryPageViewState();
}

class _FullScreenGalleryPageViewState extends State<FullScreenGalleryPageView> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentPageIndex = widget.currentIndex;
    });

    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * .9,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 35,
                color: Colors.white,
              ),
            ),
            Text(
              'gallery'.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: [
              SizedBox.expand(
                child: PageView.builder(
                  pageSnapping: true,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPageIndex = value;
                    });
                  },
                  controller: _pageController,
                  itemCount: widget.imagePaths.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: CustomNetworkImage(
                        path: widget.imagePaths[index],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 50,
                child: SizedBox(
                    child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imagePaths.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                _currentPageIndex = index;
                                _pageController.jumpToPage(_currentPageIndex);
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: index == _currentPageIndex
                                ? Colors.black
                                : Colors.black.withOpacity(.6),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: index == _currentPageIndex
                                  ? Colors.blue
                                  : Colors.grey.withOpacity(.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
