import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      locale: Locale('es', 'ES'),
      supportedLocales: [Locale('es', 'ES')],
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
  bool valorSwitch = false;
  double valorSlider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
            Switch(
                value: valorSwitch,
                onChanged: (t) {
                  setState(() {
                    valorSwitch = t;
                  });
                }),
            Slider(
                value: valorSlider,
                onChanged: (v) {
                  setState(() {
                    valorSlider = v;
                  });
                }),
            Row(
              children: alumnos
                  .map((e) => ChoiceChip(
                      onSelected: (i) {
                        setState(() {
                          if (i) {
                            alumnosSeleccionados.add(e);
                          } else {
                            alumnosSeleccionados.remove(e);
                          }
                        });
                      },
                      label: Text(e),
                      selected: alumnosSeleccionados.contains(e)))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.parse("2021-01-31"),
                    lastDate: DateTime.parse("2021-12-31")).then((value) {
                      print(value);
                    });
              },
              child: Text("Fecha"),
            ),
             ElevatedButton(
              onPressed: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now() ).then((value) {
                      print(value);
                    });
              },
              child: Text("Hora"),
            )
          ],
        ),
      ),
    );
  }
}
