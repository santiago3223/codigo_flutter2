import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  String apiUrl ="https://gateway.marvel.com/v1/public/";
  String ts = "1";
  String publicKey = "7737f4a77e5ba5406c4c67dbbd3151e6";
  String privateKey = "00763b7723ab2b6d06242cc5a3e2f8ecb42741ec";
  Hash hasher = md5;
  CharacterDataWrapper data ;


  void loadCharacters(){
    String key = hasher.convert(utf8.encode(ts+privateKey+publicKey)).toString();
    String params = "?ts=$ts&apikey=$publicKey&hash=$key";
    http.get(Uri.parse(apiUrl+"characters"+params)).then((http.Response r )  {
      if (r.statusCode==200){
        setState(() {
          data = CharacterDataWrapper.fromJson(json.decode(r.body));  
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    loadCharacters();
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data.attributionText,
            ),
          ],
        ),
      ), 
    );
  }
}
