import 'package:film_checker/models/character.dart';
import 'package:film_checker/views/blocks/info_pages/character_block.dart';
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
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            leadingWidth: MediaQuery.of(context).size.width * .9,
            toolbarHeight: 60,
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
                  'characters'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
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
