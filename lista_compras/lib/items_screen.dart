import 'package:flutter/material.dart';
import 'package:lista_compras/models/list_item.dart';
import 'package:lista_compras/models/shoping_list.dart';
import 'package:lista_compras/util/dbhelper.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  ItemsScreen(this.shoppingList);
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  DbHelper helper = DbHelper();
  List<ListItem> items;

  void initState() {
    super.initState();
    showData();
  }

  Future showData() async {
    await helper.openDb();
    items = await helper.getItems(widget.shoppingList.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: items == null ? 0 : items.length,
        itemBuilder: (c, i) => ListTile(
              title: Text(items[i].name),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),

            )),
    );
  }
}
