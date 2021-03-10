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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  List opcionesLinea1 = ["c", "<-", "%", "/"];
  List opcionesLinea2 = ["7", "8", "9", "x"];
  List opcionesLinea3 = ["4", "5", "6", "-"];
  List opcionesLinea4 = ["1", "2", "3", "+"];
  List opcionesLinea5 = ["e", "0", ".", "="];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Container(height: 150, child: TextField()),
          obtenerLinea(context, opcionesLinea1),
          obtenerLinea(context, opcionesLinea2),
          obtenerLinea(context, opcionesLinea3),
          obtenerLinea(context, opcionesLinea4),
          obtenerLinea(context, opcionesLinea5),
        ],
      ),
    );
  }

  Widget obtenerLinea(context, opciones) {
    List<Widget> botones =
        opciones.map<Widget>((e) => obtenerBoton(context, e)).toList();
    if (Orientation.portrait != MediaQuery.of(context).orientation) {
      botones.addAll([
        Expanded(child: ElevatedButton(onPressed: () {}, child: Text("("))),
        Expanded(child: ElevatedButton(onPressed: () {}, child: Text(")"))),
      ]);
    }

    return Expanded(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: botones));
  }

  Widget obtenerBoton(context, texto) {
    return Expanded(
        child: ElevatedButton(onPressed: () {}, child: Text(texto)));
  }
}
