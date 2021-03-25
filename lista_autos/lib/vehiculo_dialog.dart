import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return AlertDialog(
      title: Text(isNew ? "Nuevo vehiculo" : "Editar Vehiculo"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tipo,
            ),
            TextField(
              controller: marca,
            ),
            TextField(
              controller: modelo,
            ),
            TextField(
              controller: kilometraje,
            ),
            TextField(
              controller: imagen,
            ),
            TextField(
              controller: placa,
            ),
            TextField(
              controller: color,
            ),
            ElevatedButton(
              child: Text("Guardar"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
