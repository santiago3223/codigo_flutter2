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
      body: albums==null?Container():ListView.builder(
        itemCount: albums.items.length,
        itemBuilder: (c, i)=> ListTile(title: Text(albums.items[i].name),)),
    );
  }
}
