import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int tTrabajo= 30;
  int tBreak = 5;
  int tDescanzo = 15;

  void cambiarTTrabajo(int i) {setState(() {
    tTrabajo+=i;
  });}

  void cambiarTBreak(int i) {setState(() {
    tBreak+=i;
  });}

  void cambiarTDescanzo(int i) {setState(() {
    tDescanzo+=i;
  });}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          
          children: [
            SizedBox(height: 8,),
            Text("Tiempo trabajo:", style: TextStyle(fontSize: 25)),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {cambiarTTrabajo(-1);}, child: Text("-"))),
                Expanded(child: Text("$tTrabajo", textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)),
                Expanded(child: ElevatedButton(onPressed: () {cambiarTTrabajo(1);}, child: Text("+"))),
              ],
            ),
            SizedBox(height: 8,),
            Text("Tiempo break:", style: TextStyle(fontSize: 25)),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {cambiarTBreak(-1);}, child: Text("-"))),
                Expanded(child: Text("$tBreak", textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)),
                Expanded(child: ElevatedButton(onPressed: () {cambiarTBreak(1);}, child: Text("+"))),
              ],
            ),
            SizedBox(height: 8,),
            Text("Tiempo descanzo:", style: TextStyle(fontSize: 25)),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {cambiarTDescanzo(-1);}, child: Text("-"))),
                Expanded(child: Text("$tDescanzo", textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)),
                Expanded(child: ElevatedButton(onPressed: () {cambiarTDescanzo(1);}, child: Text("+"))),
              ],
            ),
            SizedBox(height: 8,),
            ElevatedButton(onPressed: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('trabajo', tTrabajo);
              await prefs.setInt('break', tBreak);
              await prefs.setInt('descanzo', tDescanzo);
              Navigator.pop(context);
            }, child: Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
