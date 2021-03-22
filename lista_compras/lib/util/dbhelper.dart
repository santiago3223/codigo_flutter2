import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;

  Database db;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'lista.db'),
          onCreate: (database, version) {
        database.execute(
            "CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)");
        database.execute(
            "CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER,  name TEXT, quantity INTEGER, FOREIGN KEY(idList) REFERENCES lists(id) )");
        print("Creada base de datos y sus tablas");
      }, version: version);
    }
  }
}
