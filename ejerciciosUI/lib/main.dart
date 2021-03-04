import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Ejercicio4(),
    );
  }
}

class Ejercicio4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.category,
                color: Colors.black,
              ),
              onPressed: () {}),
          centerTitle: true,
          title: Text(
            "Categories",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
          bottom: TabBar(
            labelColor: Colors.pink,
            indicatorColor: Colors.pink,
            unselectedLabelColor: Colors.black,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Para Ti"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Disenio"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Belleza"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Text("Tab1"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Tab1"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Tab1"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
