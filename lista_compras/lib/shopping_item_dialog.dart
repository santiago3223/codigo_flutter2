import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/models/list_item.dart';
import 'package:lista_compras/util/dbhelper.dart';

class ShoppingItemtDialog {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtQuantity = TextEditingController();

  Widget buildDialog(BuildContext context, ListItem item, bool isNew){
    DbHelper helper = DbHelper();

    if(!isNew){
      txtName.text = item.name;
      txtQuantity.text = item.quantity.toString();
    }else{
      txtName.text = "";
      txtQuantity.text = "";
    }

    return AlertDialog(
      title: Text(isNew?"Nueva item":"Editar item"),
      content: SingleChildScrollView(child: Column(children: [
        TextField(controller: txtName,),
        TextField(controller: txtQuantity,),
        ElevatedButton(onPressed: (){
            item.name = txtName.text;
            item.quantity = txtQuantity.text;
            helper.insertItem(item);
            Navigator.pop(context);
        }, child: Text("Guardar"))
      ],),),
    );
  }
}
