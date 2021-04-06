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

  void buscarArtistas() async {
    http.Response response = await http.get(
        Uri.parse(
            "https://api.spotify.com/v1/search?q=${controller.text}&type=artist"),
        headers: {
          "Authorization":
              "Bearer BQDkciIPkyAlaQctHhTO2MOFPhfvHPsw6kubbfMt8AhpOVwRcDZPnFQcXfILhT2y2OJtANhoDb7QTblMO8fqVVsNlW3ATZvgbrn4yMGCh-ipWRzLuAfYKMA8bkLnUKx-lGFbpFW3sUSmwtBgU_euDDXKq3BIrjhFaeDoSnvKGb7mxp3mVX8GTisEl--Wta-8gOp0sdWh_lTyiDyAQcuJxkblR6cgtLy5qx7MVMccAkUO_SC4NJ-KpjMxs1_iQ5EyL1keladtIJoYfxUHkDpS_g"
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
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                  label: Text("Atras")),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Siguiente"))
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          buscarArtistas();
        },
      ),
    );
  }
}
