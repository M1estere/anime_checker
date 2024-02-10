import 'package:film_checker/models/genre.dart';
import 'package:flutter/material.dart';

class SearchPageCategoryBlock extends StatefulWidget {
  final Genre genre;
  final List<Genre> included;
  final List<Genre> excluded;
  final Function updateFunc;

  const SearchPageCategoryBlock({
    super.key,
    required this.genre,
    required this.included,
    required this.excluded,
    required this.updateFunc,
  });

  @override
  State<SearchPageCategoryBlock> createState() =>
      _SearchPageCategoryBlockState();
}

class _SearchPageCategoryBlockState extends State<SearchPageCategoryBlock> {
  int _state = 0;
  Color _activeColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (_state) {
          case 0:
            _state = 1;
            _activeColor = Colors.blue;

            widget.included.add(widget.genre);
            widget.excluded.remove(widget.genre);
            break;
          case 1:
            _state = 2;
            _activeColor = Colors.red;

            widget.excluded.add(widget.genre);
            widget.included.remove(widget.genre);
            break;
          case 2:
            _state = 0;
            _activeColor = Colors.grey;

            widget.included.remove(widget.genre);
            widget.excluded.remove(widget.genre);
            break;
        }
        setState(() {});
        widget.updateFunc();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: _activeColor.withOpacity(.4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
          child: Text(
            widget.genre.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
