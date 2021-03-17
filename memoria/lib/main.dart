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
  List<String> opciones = [
    "https://img.icons8.com/bubbles/2x/jake.png",
    "https://img.icons8.com/bubbles/2x/futurama-bender.png",
    "https://img.icons8.com/bubbles/2x/super-mario.png",
    "https://img.icons8.com/bubbles/2x/iron-man.png",
    "https://img.icons8.com/bubbles/2x/walter-white.png",
    "https://img.icons8.com/bubbles/2x/stormtrooper.png"
  ];
  List<bool> giroTarjetas = [];
  List<GlobalKey<FlipCardState>> estados_tarjetas = [];
  int movimientos = 0;
  int indicePrimeraTarjeta;// lista que acumule las posiciones de las tarjetas ya voletadas

  void aleatorizarTarjetas() {
    giroTarjetas = [];
    opciones.forEach((element) {
      giroTarjetas.add(true);
    });
    setState(() {
      opciones.shuffle();
      giroTarjetas = giroTarjetas;
    });
  }

  void tarjetaPresionada(int i) {

    setState(() {
      movimientos++;
    });
    //nuesta lista de indices esta vacia?, si esta vacia agregamos el indice de la nueva tarjeta
    //sino, verificamos que el indice de la tarjeta no contenga la misma imagen que los indices anteriores
    // si tienen la misma foto, perdemos y llamamos al metodo reiniciar
    // sino, no hacemos nada
    // el length de nuestra lista es == 5, en este caso, ganamos 


    if (indicePrimeraTarjeta == null) {
      indicePrimeraTarjeta = i;
    } else {
      if (opciones[indicePrimeraTarjeta] == opciones[i]) {
        
        setState(() {
          giroTarjetas[i] = false;
          giroTarjetas[indicePrimeraTarjeta] = false;
        });
        indicePrimeraTarjeta = null;
      } else {
        estados_tarjetas[indicePrimeraTarjeta].currentState.toggleCard();
        estados_tarjetas[i].currentState.toggleCard();
        indicePrimeraTarjeta = null;
      }
    }
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
          Text(
            "$movimientos",
            style: TextStyle(fontSize: 40),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: opciones.length,
              itemBuilder: (BuildContext context, int index) {
                return FlipCard(
                  flipOnTouch: giroTarjetas[index] && indicePrimeraTarjeta !=index,
                  onFlipDone: (defrente) {
                    if (!defrente) {
                      tarjetaPresionada(index);
                    }
                  },
                  key: estados_tarjetas[index],
                  back: Container(
                    child: Card(
                      color: Colors.orange.shade100,
                      child: Image.network(opciones[index]),
                    ),
                  ),
                  front: Container(
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

  void reiniciar() async {
    setState(() {
      movimientos = 0;
    });

    estados_tarjetas.forEach((estadoTarjeta) {
      if (!estadoTarjeta.currentState.isFront)
        estadoTarjeta.currentState.toggleCard();
    });

    await Future.delayed(Duration(milliseconds: 500));
    aleatorizarTarjetas();
  }
}
