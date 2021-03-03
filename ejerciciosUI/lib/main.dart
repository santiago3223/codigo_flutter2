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
      home: Ejercicio2(),
    );
  }
}

class Ejercicio2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: Stack(
              children: [
                Material(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Mebina Nepal",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("UI/UX designer"),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "302",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "POSTS",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "10.3K",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "FOLLOWERS",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "120",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "FOLLOWING",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      "https://alternosradio.com/wp-content/uploads/2020/10/120366236_2728489860727307_2567081284175918216_n.jpg"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
