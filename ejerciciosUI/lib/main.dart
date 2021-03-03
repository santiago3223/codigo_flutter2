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
  List<String> imagenes = [
    "https://blog.thefork.com/es/wp-content/uploads/sites/3/2020/10/peru-cocina-ppal-1050x600-1-1024x585.jpeg",
    "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB15poFh.img?h=1080&w=1920&m=6&q=60&o=t&l=f",
    "https://infomercado.pe/wp-content/uploads/2019/05/comida-peruana.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQirXT1tOFZL4PC6mmstU6wqLqdKhzBn4gWDw&usqp=CAU",
  ];
  List<String> nombres = [
    "Lomo saltado",
    "Aji de gallina",
    "Anticucho",
    "Conbinado"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoHeader(context),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Collection",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Create new",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              buildComidas(),
              SizedBox(height: 20),
              Text(
                "Most liked posts",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      "https://i2.wp.com/aspgems.com/wp-content/uploads/2020/01/flutter-dart.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildComidas() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagenes.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 200,
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imagenes[index],
                  fit: BoxFit.cover,
                ),
              )),
              SizedBox(height: 5),
              Text(
                nombres[index],
                style: TextStyle(color: Colors.grey.shade700),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildInfoHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: Material(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                shape: CircleBorder(),
                elevation: 5.0,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      "https://alternosradio.com/wp-content/uploads/2020/10/120366236_2728489860727307_2567081284175918216_n.jpg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
