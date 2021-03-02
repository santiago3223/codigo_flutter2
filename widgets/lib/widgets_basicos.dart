import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsBasicosPage extends StatefulWidget {
  @override
  _WidgetsBasicosPageState createState() => _WidgetsBasicosPageState();
}

class _WidgetsBasicosPageState extends State<WidgetsBasicosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "normal",
              style: TextStyle(fontSize: 20),
              children: [
                TextSpan(text: " normal", style: TextStyle(fontSize: 14)),
                TextSpan(
                    text: " normal",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough)),
              ],
            ),
          ),
          Image.network(
            "https://media-exp1.licdn.com/dms/image/C4E03AQHCsjzhRRL2XQ/profile-displayphoto-shrink_200_200/0/1546881194848?e=1619049600&v=beta&t=75j3jyf1cLZnR8KVrkg9eOYS7ufxD8lj8a_ayYnSJ4U",
            width: 250,
            height: 80,
            //repeat: ImageRepeat.repeat,
            fit: BoxFit.cover,
          ),
          Icon(
            Icons.email,
            size: 200,
            color: Colors.red,
          ),
          FlatButton(
            onPressed: () {
              print("Presiono el boton verde");
            },
            child: Text(
              "flatButton",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              "flatButton",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          OutlineButton(
            onPressed: () {},
            child: Text(
              "flatButton",
              style: TextStyle(color: Colors.green),
            ),
          ),
          CupertinoButton(
              child: Text(
                "flatButton",
              ),
              onPressed: () {}),
          RaisedButton.icon(
              onPressed: () {}, icon: Icon(Icons.email), label: Text("email")),
          IconButton(icon: Icon(Icons.add), onPressed: () {})
        ],
      ),
    );
  }
}
