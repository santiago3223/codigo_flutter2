import 'package:flutter/material.dart';
import 'package:lista_compras/items_screen.dart';
import 'package:lista_compras/models/shoping_list.dart';
import 'package:lista_compras/shopping_list_dialog.dart';
import 'package:lista_compras/util/dbhelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShList();
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingLists;
  ShoppingListDialog dialog;
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey();

  void initState() {
    super.initState();
    dialog = ShoppingListDialog();
    showData();
  }

  Future showData() async {
    await helper.openDb();
    shoppingLists = await helper.getLists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold_key,
      appBar: AppBar(
        title: Text("Lista de compras"),
      ),
      body: ListView.builder(
          itemCount: shoppingLists == null ? 0 : shoppingLists.length,
          itemBuilder: (c, i) => Dismissible(
                key: Key(shoppingLists[i].id.toString()),
                background: Container(color: Colors.red,),
                onDismissed: (direction) {
                  String name = shoppingLists[i].name;
                  helper.deleteList(shoppingLists[i]);
                  shoppingLists.removeAt(i);
                  setState(() {
                    shoppingLists = shoppingLists;
                  });
                  scaffold_key.currentState.showSnackBar(
                      SnackBar(content: Text("Se ha eliminado $name")));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(shoppingLists[i].priority.toString()),
                  ),
                  title: Text(shoppingLists[i].name),
                  trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (c) => dialog.buildDialog(
                                    c, shoppingLists[i], false))
                            .then((value) => {showData()});
                      }),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ItemsScreen(shoppingLists[i])));
                  },
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
                  context: context,
                  builder: (c) =>
                      dialog.buildDialog(c, ShoppingList(0, "", 0), true))
              .then((value) => showData());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
