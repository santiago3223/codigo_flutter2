import 'package:flutter/material.dart';
import 'package:lista_compras/models/list_item.dart';
import 'package:lista_compras/models/shoping_list.dart';
import 'package:lista_compras/shopping_item_dialog.dart';
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
  ShoppingItemtDialog dialog = ShoppingItemtDialog();
  GlobalKey<ScaffoldMessengerState> scaffold_key = GlobalKey();

  void initState() {
    super.initState();
    showData();
  }

  Future showData() async {
    await helper.openDb();
    items = await helper.getItems(widget.shoppingList.id);
    setState(() {});
  }

  void eliminarItem(int i) {
    String name = items[i].name;
    helper.deleteItem(items[i]);
    items.removeAt(i);
    setState(() {
      items = items;
    });
    scaffold_key.currentState
        .showSnackBar(SnackBar(content: Text("Se ha eliminado $name")));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffold_key,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.shoppingList.name),
        ),
        body: ListView.builder(
            itemCount: items == null ? 0 : items.length,
            itemBuilder: (c, i) => Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    eliminarItem(i);
                  },
                  key: Key(items[i].id.toString()),
                  child: ListTile(
                    title: Text(items[i].name),
                    subtitle: Text(items[i].quantity),
                    trailing:
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  ),
                )),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (c) => dialog.buildDialog(
                        c, ListItem(0, widget.shoppingList.id, "", ""), true))
                .then((value) => showData());
          },
        ),
      ),
    );
  }
}
