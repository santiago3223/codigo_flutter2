import 'package:flutter/material.dart';
import 'package:marvelapi/models/character_data_wrapper.dart';
import 'package:marvelapi/views/comic_view.dart';

class CharacterView extends StatelessWidget {
  final Character character;
  const CharacterView({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(character.thumbnail.path + "/portrait_uncanny.jpg"),
            Text(character.description),
            Text(
              "COMICS:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: character.comics.items.length,
                  itemBuilder: (c, i) => ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ComicView(
                                      url: character
                                          .comics.items[i].resourceUri)));
                        },
                        title: Text(character.comics.items[i].name),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
