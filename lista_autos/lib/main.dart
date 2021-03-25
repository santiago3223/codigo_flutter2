import 'package:flutter/material.dart';
import 'package:lista_autos/dbhelper.dart';
import 'package:lista_autos/vehiculo_dialog.dart';

import 'models/vehiculo.dart';

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
  int _counter = 0;
  VehiculoDialog dialog = VehiculoDialog();
  List<Vehiculo> vehiculos;
  List<Vehiculo> vehiculos_filtrados;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void getData() {
    DbHelper().getVehiculos().then((value) {
      setState(() {
        vehiculos = value;
        vehiculos_filtrados = vehiculos;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (palabra) {
              List<Vehiculo> filtradas = [];
              for (Vehiculo v in vehiculos) {
                if (v.marca.toLowerCase().contains(palabra.toLowerCase()) ||
                    v.modelo.toLowerCase().contains(palabra.toLowerCase())) {
                  filtradas.add(v);
                }
              }
              setState(() {
                vehiculos_filtrados = filtradas;
              });
            },
          ),
          vehiculos_filtrados == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: vehiculos_filtrados.length,
                      itemBuilder: (c, i) => ListTile(
                          leading: Text(
                              vehiculos_filtrados[i].kilometraje.toString()),
                          title: Text(vehiculos_filtrados[i].marca),
                          subtitle: Text(vehiculos_filtrados[i].modelo),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.details),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (c) => dialog.buildDialog(
                                            c, vehiculos[i], false, false));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                            context: context,
                                            builder: (c) => dialog.buildDialog(
                                                c, vehiculos[i], false, true))
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                ),
                              ],
                            ),
                          ))))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (c) => dialog.buildDialog(
                c, Vehiculo(0, "", "", "", 0, "", "", ""), true, true),
          ).then((value) {
            setState(() {});
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
