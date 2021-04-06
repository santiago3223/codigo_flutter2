import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:spotifyapi/moderls/busqueda_artistas.dart';

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
  BusquedaArtistas busquedaArtistas;
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
          "Bearer BQB7vZxC8cfDLVNWQQyUU2GUB7aCpwbMJkw3tEJD1VwWavw0OpI28prT5yfhfhpsAgfrWPQpnooRWlwD_aRfj51J79g_mkJDUpVSnbX9qpz627g56Qunt5cJuwFC2RKZ1L7tDqC8VPmvURXA4H-Y2aL8Z4yzOV1Uhd7SwDJqskSUIpWzgYZ1iW5bvhDlZztCbMlWxTsgiDW6LvHlZwSKXJUB81cJDCmCWVYpvQbx8WKwcP3Uuu8tHbc-xa1oVItIhJCq9ScKSv9J2Eam6rabxA"
    });
    if (response.statusCode == 200) {
      BusquedaArtistas bArtistas =
          BusquedaArtistas.fromJson(jsonDecode(response.body));
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
                    filtros[0]["valor"] = b;
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
          buscarArtistas(apiUrl + "search?q=${controller.text}&type=artist");
        },
      ),
    );
  }
}
