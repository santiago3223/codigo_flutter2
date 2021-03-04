import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Ejercicio3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent.shade100])),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
                  IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                ],
              ),
              Text(
                "Date mate",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontStyle: FontStyle.italic),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/3/35/Elvis_Presley_Jailhouse_Rock.jpg"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("1.5Km away"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text(
                "Elvis - 22",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Arequipa, Arequipa, Peru",
                  style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.instagram),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.facebookF),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.twitter),
                    onPressed: () {},
                    color: Colors.grey,
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purpleAccent,
                        Colors.pinkAccent.shade100
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.user),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.favorite, color: Colors.pink),
                        backgroundColor: Colors.white),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
