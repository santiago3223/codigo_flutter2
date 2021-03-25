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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: DbHelper().getVehiculos(),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            List<Vehiculo> vehiculos = snapshot.data;
            return ListView.builder(
                itemCount: vehiculos.length,
                itemBuilder: (c, i) => ListTile(
                    leading: Text(vehiculos[i].kilometraje.toString()),
                    title: Text(vehiculos[i].marca),
                    subtitle: Text(vehiculos[i].modelo),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.details),
                            onPressed: () {

                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (c) => dialog.buildDialog(
                                      c,
                                      vehiculos[i],
                                      false)).then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        ],
                      ),
                    )));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
                  context: context,
                  builder: (c) => dialog.buildDialog(
                      c, Vehiculo(0, "", "", "", 0, "", "", ""), true))
              .then((value) {
            setState(() {});
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
