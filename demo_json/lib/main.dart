import 'dart:convert';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String json =
        '{"nombre":"Santiago","edad":15, "salario":1.5,"soltero":true,"comentarios_adicionales":null}';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Persona.fromMap(jsonDecode(json))
                  .edad
                  .toString(), // nos puede retornar un mapa, o lista de mapas
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Persona {
  String nombre;
  int edad;
  double salario;
  bool soltero;
  String comentarios_adicionales;

  Persona.fromMap(Map<String, dynamic> map) {
    nombre = map["nombre"];
    edad = map["edad"];
    salario = map["salario"];
    soltero = map["soltero"];
    comentarios_adicionales = map["comentarios_adicionales"];
  }
}
