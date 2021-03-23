import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/models/shoping_list.dart';
import 'package:lista_compras/util/dbhelper.dart';

class ShoppingListDialog {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew){
    DbHelper helper = DbHelper();

    if(!isNew){
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }

    return AlertDialog(
      title: Text(isNew?"Nueva lista":"Editar lista"),
      content: SingleChildScrollView(child: Column(children: [
        TextField(controller: txtName,),
        TextField(controller: txtPriority,),
        ElevatedButton(onPressed: (){
            list.name = txtName.text;
            list.priority = int.parse(txtPriority.text);
            helper.insertList(list);
            Navigator.pop(context);
        }, child: Text("Guardar"))
      ],),),
    );
  }
}
