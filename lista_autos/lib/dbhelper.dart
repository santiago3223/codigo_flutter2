import 'package:lista_autos/models/vehiculo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Database db;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), "lista.db"),
          onCreate: (database, version) {
        String sql =
            "CREATE TABLE vehiculos (id INTEGER PRIMARY KEY, tipo TEXT, marca TEXT, modelo TEXT, kilometraje DOUBLE, imagen TEXT, placa TEXT, color TEXT);";
        database.execute(sql);
        print("Tabla creada correctamente");
      }, version: version);
    }
    return db;
  }

  Future<int> insertVehiculo(Vehiculo v) async {
    int id = await db.insert("vehiculos", v.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Vehiculo>> getVehiculos() async {
    await openDb();
    return (await db.query("vehiculos"))
        .map((e) => Vehiculo.fromMap(e))
        .toList();
  }
}
