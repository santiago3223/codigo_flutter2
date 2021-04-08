import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:spotifyapi/utils.dart';

import 'moderls/albums.dart';
import 'moderls/artists.dart' as artistas;
import 'package:http/http.dart' as http;

class ArtistView extends StatefulWidget {
  final artistas.Item artist;

  ArtistView(this.artist);

  @override
  _ArtistViewState createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {
  Logger logger = Logger();
  Albums albums;

  void buscarAlbums() async {
    http.Response response = await http.get(
        Uri.parse(apiUrl + "artists/${widget.artist.id}/albums"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Albums abl = Albums.fromJson(jsonDecode(response.body));
      setState(() {
        albums = abl;
      });
    } else {
      logger.e(jsonDecode(response.body).toString());
    }
  }

  @override
  void initState() {
    buscarAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artist.name),
      ),
      body: buildAlbums()
    );
  }

   Widget buildAlbums() {
    if (albums == null) {
      return Container();
    } else {
      return Column(
        children: [
          Text(
            "Albums",
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: albums.items.length,
                itemBuilder: (c, i) => Container(
                      height: 200,
                      width: 200,
                      child: Card(
                          child: Column(
                        children: [
                          Container(
                              height: 25,
                              child: Text(
                                albums.items[i].name,
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          albums.items[i].images.length > 0
                              ? Image.network(
                                  albums.items[i].images[0].url,
                                  height: 100,
                                )
                              : Container(
                                  height: 100,
                                ),
                          Text(albums.items[i].releaseDate),
                          Text(albums.items[i].totalTracks
                              .toString()),
                        ],
                      )),
                    )),
          ),
        ],
      );
    }
  }
}
