import 'package:flutter/material.dart';

class LayoutWidgets extends StatefulWidget {
  @override
  _LayoutWidgetsState createState() => _LayoutWidgetsState();
}

class _LayoutWidgetsState extends State<LayoutWidgets> {
  List<String> palabras = [
    "Santiago",
    "willy",
    'Miguel',
    "maria",
    "teresa",
    "pedro",
    "martin"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 10),
            color: Colors.red),
        margin: EdgeInsets.all(45),
        padding: EdgeInsets.all(45),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.green,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: palabras
                    .map((e) =>
                        Padding(padding: EdgeInsets.all(50), child: Text(e)))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
