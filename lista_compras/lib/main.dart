import 'package:flutter/material.dart';
import 'package:lista_compras/items_screen.dart';
import 'package:lista_compras/models/shoping_list.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ShList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DbHelper helper = DbHelper();
          await helper.openDb();

          helper.insertList(ShoppingList(0, "Vegetales", 100));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingLists;

  void initState() {
    super.initState();
    showData();
  }

  Future showData() async {
    await helper.openDb();
    shoppingLists = await helper.getLists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shoppingLists == null ? 0 : shoppingLists.length,
        itemBuilder: (c, i) => ListTile(
              leading: CircleAvatar(
                child: Text(shoppingLists[i].priority.toString()),
              ),
              title: Text(shoppingLists[i].name),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => ItemsScreen(shoppingLists[i])));
              },
            ));
  }
}
