
import 'package:flutter/material.dart';

class LayoutsWidgets2 extends StatefulWidget {
  @override
  _LayoutsWidgets2State createState() => _LayoutsWidgets2State();
}

class _LayoutsWidgets2State extends State<LayoutsWidgets2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Hola"),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {},
                  child: Text("boton"),
                ),
                Expanded(
                  child: Text(
                      "Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola Hola"),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 200,
                    height: 200,
                    color: Colors.green,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 200,
                    height: 200,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text("$index"),
                ),
              ),
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.blue,
                  child: Text("$index")),
            ))
          ],
        ),
      ),
    );
  }
}
