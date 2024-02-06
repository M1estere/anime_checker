import 'package:film_checker/api/genres_controller.dart';
import 'package:film_checker/api/seasons_controller.dart';
import 'package:film_checker/views/blocks/common/genre_block.dart';
import 'package:film_checker/views/blocks/common/season_block.dart';
import 'package:flutter/material.dart';

class SearchSectionPageView extends StatefulWidget {
  final String title;

  const SearchSectionPageView({
    super.key,
    required this.title,
  });

  @override
  State<SearchSectionPageView> createState() => _SearchSectionPageViewState();
}

class _SearchSectionPageViewState extends State<SearchSectionPageView> {
  List _content = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.title.toLowerCase() == 'genres') {
      gatherInfo(1).then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else if (widget.title.toLowerCase() == 'seasons') {
      gatherInfo(3).then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  Future gatherInfo(int type) async {
    if (type == 1) {
      _content = await GenresController().getAllGenres();
    } else if (type == 3) {
      _content = await SeasonsController().getAllSeasons();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
              widget.title.toUpperCase(),
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
        child: !_isLoading
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Divider(
                      color: Colors.white,
                      thickness: .7,
                      height: 1,
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (widget.title.toLowerCase() == 'genres') {
                    return GenreBlock(
                      orderNumber: index + 1,
                      genre: _content[index],
                    );
                  } else if (widget.title.toLowerCase() == 'seasons') {
                    return SeasonBlock(season: _content[index]);
                  }
                  return GenreBlock(
                    orderNumber: index + 1,
                    genre: _content[index],
                  );
                },
                itemCount: _content.length,
              )
            : const Center(),
      ),
    );
  }
}
