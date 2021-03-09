import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de unidades',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversorUnidades(),
    );
  }
}

class ConversorUnidades extends StatefulWidget {
  @override
  _ConversorUnidadesState createState() => _ConversorUnidadesState();
}

class _ConversorUnidadesState extends State<ConversorUnidades> {
  List unidades = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'libras'
  ];
  String unidadInicio = 'metros';
  String unidadDestino = 'metros';
  String resultado="";

  TextEditingController _controllerInicio = TextEditingController();

  List<List> factores_conversion = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0],
    [0, 0, 1, 0.0001, 0, 0, 0.00220462],
    [0, 0, 1000, 1, 0, 0, 2.20462],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de unidades"),
      ),
      body: Column(
        children: [
          Text("Monto:"),
          TextField(
            controller: _controllerInicio,
            decoration: InputDecoration(hintText: "Ingrese valor a convertir"),
          ),
          Text("De:"),
          DropdownButton(
            value: unidadInicio,
            items: unidades
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (i) {
              setState(() {
                unidadInicio = i;
              });
            },
          ),
          DropdownButton(
            value: unidadDestino,
            items: unidades
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (i) {
              setState(() {
                unidadDestino = i;
              });
            },
          ),
          Text("A:"),
          ElevatedButton(
            child: Text("Convertir"),
            onPressed: () {
              Convertir();
            },
          ),
          Text(resultado)
        ],
      ),
    );
  }

  void Convertir() {
    
    double numero = double.parse(_controllerInicio.text); 
    double res = 0.0;
   
    res = numero * factores_conversion[unidades.indexOf(unidadInicio)][unidades.indexOf(unidadDestino)];

    setState(() {
      resultado = res.toString() + " " + unidadDestino;
    });
  }
}
