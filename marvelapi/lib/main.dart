import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvelapi/utils.dart';
import 'package:marvelapi/views/character_view.dart';
import 'dart:convert';

import 'models/character_data_wrapper.dart';

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
      home: MyHomePage(title: 'MarvelAPI'),
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
  Hash hasher = md5;
  CharacterDataWrapper data;

  void loadCharacters() {
    String key =
        hasher.convert(utf8.encode(ts + privateKey + publicKey)).toString();
    String params = "?ts=$ts&apikey=$publicKey&hash=$key&limit=100";
    http.get(Uri.parse(apiUrl + "characters" + params)).then((http.Response r) {
      if (r.statusCode == 200) {
        setState(() {
          data = CharacterDataWrapper.fromJson(json.decode(r.body));
        });
      }
      print(r.body);
    });
  }

  @override
  void initState() {
    loadCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: data.data.results.length,
                itemBuilder: (c, i) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  CharacterView(character: data.data.results[i])));
                    },
                    leading: Image.network(data.data.results[i].thumbnail.path +
                        "/landscape_small.jpg"),
                    title: Text(data.data.results[i].name),
                  );
                }));
  }
}
