import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'moderls/artists.dart';
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
  String apiUrl = "https://api.spotify.com/v1/";

  void buscarArtistas(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "Bearer BQB9CdB9kBsvrb4xAQgUuj5tOHqQU0sMUSy1O99E5D_5u4bsUr7A_eaTDz4FHE9KIrUUHVHL11amXKxN3cUTxoBiEzCss83SUg8SRTiPRpRlGDD14DOjwYKAEkFWY7xBjRZSbDw5SEd84L8XeKm7_I6NogMmOhd4zUPkalWvoluXJuyIHPe70pnD8o5P18522DE5ij9-aB5CdFwdz02HKlAH-vmPb17Tz2VKfqtOZ-72pea6EEK5md4_4NnAizzr2SpAeOV9k9q5tA0UWhpEJA"
    });
    if (response.statusCode == 200) {
      Busqueda bArtistas =
          Busqueda.fromJson(jsonDecode(response.body));
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
      body: Column(
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
          Expanded(
            child: Container(
                child: busquedaArtistas == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: busquedaArtistas.artists.items.length,
                        itemBuilder: (c, i) {
                          List<Item> artistas = busquedaArtistas.artists.items;
                          return ListTile(
                            leading: artistas[i].images.length == 0
                                ? Container(
                                    width: 70,
                                  )
                                : Image.network(
                                    artistas[i].images[0].url,
                                    width: 70,
                                  ),
                            title: Text(artistas[i].name),
                            subtitle: Text(artistas[i].genres.join(", ")),
                            trailing:
                                Text(artistas[i].followers.total.toString()),
                          );
                        },
                      )),
          ),
          Row(
            children: [
              busquedaArtistas == null ||
                      busquedaArtistas.artists.previous == null
                  ? Container()
                  : ElevatedButton.icon(
                      onPressed: () {
                        buscarArtistas(busquedaArtistas.artists.previous);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Atras")),
              busquedaArtistas == null || busquedaArtistas.artists.next == null
                  ? Container()
                  : ElevatedButton.icon(
                      onPressed: () {
                        buscarArtistas(busquedaArtistas.artists.next);
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Siguiente"))
            ],
          )
        ],
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
}
