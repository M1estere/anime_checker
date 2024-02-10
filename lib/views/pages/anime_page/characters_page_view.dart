import 'package:film_checker/models/character.dart';
import 'package:film_checker/views/blocks/info_pages/character_block.dart';
import 'package:film_checker/views/support/default_sliver_appbar.dart';
import 'package:flutter/material.dart';

class CharactersPageView extends StatefulWidget {
  final List<Character> characters;

  const CharactersPageView({
    super.key,
    required this.characters,
  });

  @override
  State<CharactersPageView> createState() => _CharactersPageViewState();
}

class _CharactersPageViewState extends State<CharactersPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const DefaultSliverAppBar(title: 'characters'),
          SliverList.separated(
            itemBuilder: (context, index) => index != 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Divider(
                      color: Colors.white,
                      thickness: .7,
                      height: 1,
                    ),
                  )
                : const Center(),
            separatorBuilder: (context, index) => CharacterInfoBlock(
              character: widget.characters[index],
            ),
            itemCount: widget.characters.length,
          ),
        ],
      ),
    );
  }
}
