import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:logger_flutter/logger_flutter.dart';
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

  void buscarArtistas() async {
    http.Response response =
        await http.get(Uri.parse("https://api.spotify.com/v1/search?q=metallica&type=artist"),headers: {
          "Authorization" : "Bearer BQDW9LPYvUc6AUV39Tgb68KLtgWeOWZbZFgI1TYyhommiX6kPGJE9g93-2TMyclVd7c2BeNP16X2yjhbU-8AMVNhvoQDcLX394zIu78jyCLqzmnzPOiY7pIJv2t-OCTRuXbO9IwP1KhZIcUDFs043eLjReRsOhb2w6vor7LJlsCwwdESkhyWnU_U08QvjPiJflpwPsl2JbgboYdeojPhu4u7MNHeEmyquh9uTAu2H7_P4ILuuJP3MtgEMy-2xfIg0QHthQRbtTm6-A1tzpdU4A"
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
      body: Container(
        child: ListView.builder(
          itemCount: busquedaArtistas.artists.items.length,
          itemBuilder: (c,i)=>ListTile(title: Text(busquedaArtistas.artists.items[i].name),)),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.search), onPressed: (){
        buscarArtistas();
      },),
    );
  }
}
