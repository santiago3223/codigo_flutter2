import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<String> opciones = ['a', 'b', 'c', 'd', 'e', 'f'];
  List<GlobalKey<FlipCardState>> estados_tarjetas = [];

  void aleatorizarTarjetas() {
    setState(() {
      opciones.shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
    List<String> tmp = List.from(opciones);
    opciones.addAll(tmp); // duplicamos las alternativas
    estados_tarjetas = [];
    opciones.forEach((element) {
      estados_tarjetas.add(GlobalKey<FlipCardState>());
    });
    aleatorizarTarjetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text("00"),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: opciones.length,
              itemBuilder: (BuildContext context, int index) {
                return FlipCard(
                  key: estados_tarjetas[index],
                  front: Container(
                    child: Card(
                      color: Colors.orange.shade100,
                      child: Text(
                        opciones[index],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  back: Container(
                    child: Card(
                      color: Colors.orange.shade300,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), onPressed: reiniciar),
    );
  }

  void reiniciar() {
    estados_tarjetas.forEach((estadoTarjeta) {
      if (estadoTarjeta.currentState.isFront)
        estadoTarjeta.currentState.toggleCard();
    });
    aleatorizarTarjetas();
  }
}
