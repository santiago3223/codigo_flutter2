import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_autos/dbhelper.dart';
import 'package:lista_autos/models/vehiculo.dart';

class VehiculoDialog {
  TextEditingController tipo = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController kilometraje = TextEditingController();
  TextEditingController imagen = TextEditingController();
  TextEditingController placa = TextEditingController();
  TextEditingController color = TextEditingController();

  Widget buildDialog(BuildContext c, Vehiculo v, bool isNew) {
    if (isNew) {
      tipo.text = "";
      marca.text = "";
      modelo.text = "";
      kilometraje.text = "";
      imagen.text = "";
      placa.text = "";
      color.text = "";
    } else {
      tipo.text = v.tipo;
      marca.text = v.marca;
      modelo.text = v.modelo;
      kilometraje.text = v.kilometraje.toString();
      imagen.text = v.imagen;
      placa.text = v.placa;
      color.text = v.color;
    }

    DbHelper helper = DbHelper();
    return AlertDialog(
      title: Text(isNew ? "Nuevo vehiculo" : "Editar Vehiculo"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tipo,
              decoration: InputDecoration(hintText: "Tipo"),
            ),
            TextField(
              controller: marca,
              decoration: InputDecoration(hintText: "Marca"),
            ),
            TextField(
              controller: modelo,
              decoration: InputDecoration(hintText: "Modelo"),
            ),
            TextField(
              controller: kilometraje,
              decoration: InputDecoration(hintText: "Km"),
            ),
            TextField(
              controller: imagen,
              decoration: InputDecoration(hintText: "Imagen"),
            ),
            TextField(
              controller: placa,
              decoration: InputDecoration(hintText: "Placa"),
            ),
            TextField(
              controller: color,
              decoration: InputDecoration(hintText: "Color"),
            ),
            ElevatedButton(
              child: Text("Guardar"),
              onPressed: () {
                v.tipo = tipo.text;
                v.marca = marca.text;
                v.modelo = modelo.text;
                v.kilometraje = double.parse(kilometraje.text);
                v.imagen = imagen.text;
                v.placa = placa.text;
                v.color = color.text;
                helper.insertVehiculo(v);
                Navigator.pop(c);
              },
            )
          ],
        ),
      ),
    );
  }
}
