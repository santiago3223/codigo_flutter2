import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:marvelapi/models/comic_data_wrapper.dart';
import 'package:marvelapi/utils.dart';
import 'package:http/http.dart' as http;

class ComicView extends StatefulWidget {
  final String url;

  const ComicView({Key key, this.url}) : super(key: key);

  @override
  _ComicViewState createState() => _ComicViewState();
}

class _ComicViewState extends State<ComicView> {
  Hash hasher = md5;
  ComicDataWrapper data;

  void loadComics() {
    String key =
        hasher.convert(utf8.encode(ts + privateKey + publicKey)).toString();
    String params = "?ts=$ts&apikey=$publicKey&hash=$key";
    http.get(Uri.parse(widget.url + params)).then((http.Response r) {
      if (r.statusCode == 200) {
        setState(() {
          data = ComicDataWrapper.fromJson(json.decode(r.body));
        });
      }
      print(r.body);
    });
  }

  @override
  void initState() {
    loadComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null? Scaffold(body: Center(child: CircularProgressIndicator(),),): Scaffold(
      appBar: AppBar(
        title: Text(data.data.results[0].title),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Text(
              "NUMBER:" + data.data.results[0].issueNumber.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Image.network(
                data.data.results[0].thumbnail.path + "/portrait_uncanny.jpg"),
            Text("Writen by:", style: Theme.of(context).textTheme.headline6,),
            Text(data.data.results[0].creators.items
                .map((e) => e.name)
                .toList()
                .join(" - ")),
            Text("Description:", style: Theme.of(context).textTheme.headline6,),    
            Text(data.data.results[0].description ?? ""),
          ],
        ),
      ),
    );
  }
}
