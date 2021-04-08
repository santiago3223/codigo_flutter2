import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:spotifyapi/artist_view.dart';
import 'package:spotifyapi/utils.dart';

import 'moderls/busqueda.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Logger logger = Logger();
  Busqueda busquedaArtistas;
  TextEditingController controller = TextEditingController();
  List<Map> filtros = [
    {"nombre": "album", "valor": false},
    {"nombre": "artist", "valor": false},
    {"nombre": "playlist", "valor": false},
    {"nombre": "track", "valor": false},
  ];

  void buscarArtistas(String url) async {
    http.Response response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      Busqueda bArtistas = Busqueda.fromJson(jsonDecode(response.body));
      setState(() {
        busquedaArtistas = bArtistas;
      });
    } else {
      logger.e(jsonDecode(response.body).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: Text("Album"),
                  selected: filtros[0]["valor"],
                  onSelected: (b) {
                    setState(() {
                      filtros[0]["valor"] = b;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text("Artista"),
                  selected: filtros[1]["valor"],
                  onSelected: (b) {
                    setState(() {
                      filtros[1]["valor"] = b;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text("Playlist"),
                  selected: filtros[2]["valor"],
                  onSelected: (b) {
                    setState(() {
                      filtros[2]["valor"] = b;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text("Cancion"),
                  selected: filtros[3]["valor"],
                  onSelected: (b) {
                    setState(() {
                      filtros[3]["valor"] = b;
                    });
                  },
                ),
              ],
            ),
            buildArtists(),
            buildPlaylists()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          String tipos = filtros
              .where((element) => element["valor"])
              .map((e) => e["nombre"])
              .toList()
              .join(",");

          buscarArtistas(apiUrl + "search?q=${controller.text}&type=$tipos");
        },
      ),
    );
  }

  Widget buildArtists() {
    if (busquedaArtistas == null || busquedaArtistas.artists == null) {
      return Container();
    }

    return Column(
      children: [
        Text(
          "Artistas",
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: busquedaArtistas.artists.items.length,
            itemBuilder: (c, i) {
              return Container(
                height: 200,
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) =>
                                ArtistView(busquedaArtistas.artists.items[i])));
                  },
                  child: Card(
                      child: Column(
                    children: [
                      Container(
                          height: 25,
                          child: Text(
                            busquedaArtistas.artists.items[i].name,
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      busquedaArtistas.artists.items[i].images.length > 0
                          ? Image.network(
                              busquedaArtistas.artists.items[i].images[0].url,
                              height: 100,
                            )
                          : Container(
                              height: 100,
                            ),
                      Text(busquedaArtistas.artists.items[i].popularity
                          .toString()
                          .toString()),
                    ],
                  )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildPlaylists() {
    if (busquedaArtistas == null || busquedaArtistas.playlists == null) {
      return Container();
    } else {
      return Column(
        children: [
          Text(
            "Playlists",
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: busquedaArtistas.playlists.items.length,
                itemBuilder: (c, i) => Container(
                      height: 200,
                      width: 200,
                      child: Card(
                          child: Column(
                        children: [
                          Container(
                              height: 25,
                              child: Text(
                                busquedaArtistas.playlists.items[i].name,
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          busquedaArtistas.playlists.items[i].images.length > 0
                              ? Image.network(
                                  busquedaArtistas
                                      .playlists.items[i].images[0].url,
                                  height: 100,
                                )
                              : Container(
                                  height: 100,
                                ),
                          Text(busquedaArtistas
                              .playlists.items[i].owner.displayName),
                          Text(busquedaArtistas.playlists.items[i].tracks.total
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
