import 'package:lista_compras/models/list_item.dart';
import 'package:lista_compras/models/shoping_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 3;
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Database db;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'lista.db'),
          onCreate: (database, version) {
        database.execute(
            "CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)");
        database.execute(
            "CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER,  name TEXT, quantity TEXT, FOREIGN KEY(idList) REFERENCES lists(id) )");
        print("Creada base de datos y sus tablas");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print("nueva version");
      }
      , version: version);
    }
    return db;
  }

  Future testDb() async {
    db = await openDb();
    await db.execute("INSERT INTO lists VALUES (0, 'Fruta', 2) ");
    await db.execute("INSERT INTO items VALUES (0, 0, 'Manzanas', '2 Kg') ");

    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<int> insertList(ShoppingList list) async {
    int id = await db.insert("lists", list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertItem(ListItem item) async {
    int id = await db.insert("items", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    List<Map<String, dynamic>> maps = await db.query("lists");
    return maps.map((e) => ShoppingList.fromMap(e)).toList();
  }

  Future<List<ListItem>> getItems(int idList) async {
    List<Map<String, dynamic>> maps =
        await db.query("items", where: 'idList=?', whereArgs: [idList]);
    return maps.map((e) => ListItem.fromMap(e)).toList();
  }

  Future<int> deleteList(ShoppingList list) async {
    int result =
        await db.delete("items", where: "idList=?", whereArgs: [list.id]);
    result = await db.delete("lists", where: "id=?", whereArgs: [list.id]);
    return result;
  }

  Future<int> deleteItem(ListItem item) async {
    int result = await db.delete("items", where: "id=?", whereArgs: [item.id]);
    return result;
  }
}
