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
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.pink.shade100,
                        ),
                        Container(
                            margin: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/3/35/Elvis_Presley_Jailhouse_Rock.jpg",
                                    width: 75,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "How to seem like you always have your shot together, How to seem like you always have your shot together , How to seem like you always have your shot together",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.pink,
                                              size: 36,
                                            ),
                                            Text(
                                              "Jonhy Vino",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "4 min",
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("read")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pink,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
    );
  }
}
