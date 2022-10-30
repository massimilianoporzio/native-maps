import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    final dbPath = await sql.getDatabasesPath(); //get the path of sqlite file
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      //*code to initialize
      String query =
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT, image TEXT)';
      return db.execute(query);
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    //open existing or create new one (version)

    final sqlDb = await DBHelper.database();
    //*database creato o aperto
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();
    return sqlDb.query(table);
  }
}
