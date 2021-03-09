import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Formularios(),
    );
  }
}

class Formularios extends StatefulWidget {
  @override
  _FormulariosState createState() => _FormulariosState();
}

class _FormulariosState extends State<Formularios> {
  TextEditingController _controller = TextEditingController();

  List alumnos = ["Willy", "Jesus", "Daphne"];
  String seleccion = "Willy";
  String seleccionDropDown = "Willy";
  List alumnosSeleccionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            maxLength: 5,
            keyboardType: TextInputType.emailAddress,
            controller: _controller,
            onChanged: (s) {
              print(s);
            },
            onEditingComplete: () {
              print("Termino");
            },
            onSubmitted: (s) {
              print("Submited");
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                prefixText: "Pagar:",
                suffixText: ".00",
                hintText: "Monto",
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            maxLines: 5,
            keyboardType: TextInputType.emailAddress,
            onChanged: (s) {
              print(s);
            },
            onEditingComplete: () {
              print("Termino");
            },
            onSubmitted: (s) {
              print("Submited");
            },
            decoration: InputDecoration(
                labelText: "Nombre",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
          Column(
            children: alumnos
                .map(
                  (e) => Row(
                    children: [
                      Radio(
                        value: e,
                        groupValue: seleccion,
                        onChanged: (i) {
                          setState(() {
                            seleccion = i;
                          });
                        },
                      ),
                      Text(e)
                    ],
                  ),
                )
                .toList(),
          ),
          DropdownButton(
            value: seleccionDropDown,
            onChanged: (i) {
              setState(() {
                seleccionDropDown = i;
              });
            },
            items: alumnos
                .map((e) => (DropdownMenuItem(value: e, child: Text(e))))
                .toList(),
          ),
          Column(
            children: alumnos
                .map(
                  (e) => Row(
                    children: [
                      Checkbox(
                        value: alumnosSeleccionados.contains(e),
                        onChanged: (i) {
                          setState(() {
                            if (i) {
                              alumnosSeleccionados.add(e);
                            } else {
                              alumnosSeleccionados.remove(e);
                            }
                          });
                        },
                      ),
                      Text(e)
                    ],
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              print(_controller.text);
            },
            child: Text("Boton"),
          )
        ],
      ),
    );
  }
}
