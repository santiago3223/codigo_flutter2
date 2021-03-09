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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Container(height: 150, child: TextField()),
          obtenerPrimeraLinea(context),
          obtenerPrimeraLinea(context),
          obtenerPrimeraLinea(context),
          obtenerPrimeraLinea(context),
          
        ],
      ),
    );
  }
}

Widget obtenerPrimeraLinea(context) {
  return Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (Orientation.portrait == MediaQuery.of(context).orientation)
              ? [
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                ]
              : [
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                  Expanded(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("C"))),
                ]));
}
