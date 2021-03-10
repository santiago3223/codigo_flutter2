import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  List opcionesLinea1 = [];
  List opcionesLinea2 = [];
  List opcionesLinea3 = [];
  List opcionesLinea4 = [];
  List opcionesLinea5 = [];
  List historial = [];
  String display = "";

  @override
  void initState() {
    super.initState();
    opcionesLinea1 = opcionesLinea1 = [
      BotonCalculadora(etiqueta: "C", funcion: borrarTodo),
      BotonCalculadora(etiqueta: "<-", funcion: borrarCaracter),
      BotonCalculadora(etiqueta: "%", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "/", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "(", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: ")", funcion: agregarCaracter),
    ];
    opcionesLinea2 = opcionesLinea2 = [
      BotonCalculadora(etiqueta: "7", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "8", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "9", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "*", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "^2", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "sqrt", funcion: raiz),
    ];
    opcionesLinea3 = opcionesLinea3 = [
      BotonCalculadora(etiqueta: "4", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "5", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "6", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "-", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "^", funcion: potencia),
      BotonCalculadora(etiqueta: "log", funcion: lg),
    ];
    opcionesLinea4 = opcionesLinea4 = [
      BotonCalculadora(etiqueta: "1", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "2", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "3", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "+", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "sin", funcion: sin),
      BotonCalculadora(etiqueta: "ln", funcion: ln),
    ];
    opcionesLinea5 = opcionesLinea5 = [
      BotonCalculadora(etiqueta: "e", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "0", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: ".", funcion: agregarCaracter),
      BotonCalculadora(etiqueta: "=", funcion: resolver),
      BotonCalculadora(etiqueta: "cos", funcion: cos),
      BotonCalculadora(etiqueta: "tan", funcion: tan),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Orientation.portrait == MediaQuery.of(context).orientation
              ? Container(
                  padding: EdgeInsets.all(8),
                  height: 150,
                  child: ListView(
                    children: historial
                        .map((e) => Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              e,
                              textAlign: TextAlign.left,
                            )))
                        .toList(),
                  ))
              : Container(),
          Text(
            display,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.right,
          ),
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
    if (Orientation.portrait == MediaQuery.of(context).orientation) {
      botones.removeLast();
      botones.removeLast();
    }

    return Expanded(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: botones));
  }

  Widget obtenerBoton(context, BotonCalculadora botonCalculadora) {
    return Expanded(
        child: TextButton(
            onPressed: () {
              botonCalculadora.funcion(botonCalculadora.etiqueta);
            },
            child: Text(
              botonCalculadora.etiqueta,
              style: TextStyle(fontSize: 25),
            )));
  }

  void borrarTodo(texto) {
    setState(() {
      display = "";
    });
  }

  void borrarCaracter(texto) {
    setState(() {
      display = display.substring(0, display.length - 1);
    });
  }

  void agregarCaracter(texto) {
    setState(() {
      display += texto;
    });
  }

  void alCuadrado(texto) {
    setState(() {
      display += texto;
    });
  }

  void raiz(texto) {
    setState(() {
      display += texto+"(";
    });
  }


  void potencia(texto) {
    setState(() {
      display += texto;
    });
  }

  void lg(texto) {
    setState(() {
      display = "log("+display+",";
    });
  }

  void ln(texto) {
    setState(() {
      display += texto+"(";
    });
  }
  void sin(texto) {
    setState(() {
      display += texto+"(";
    });
  }
  void cos(texto) {
    setState(() {
      display += texto+"(";
    });
  }
  void tan(texto) {
    setState(() {
      display += texto+"(";
    });
  }

  void resolver(texto) {
    Parser p = Parser();
    ContextModel cm = ContextModel();
    try {
      Expression exp = p.parse(display);
      double e = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        historial.add(display);
        display = e.toString();
      });
    } on Error {
      setState(() {
        display = "Syntax Error";
      });
    }
  }
}

class BotonCalculadora {
  String etiqueta;
  Function funcion;

  BotonCalculadora({this.etiqueta, this.funcion});
}
