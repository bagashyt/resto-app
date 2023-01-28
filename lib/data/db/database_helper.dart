import 'package:resto_app/data/model/favorite_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/restoapp.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tblFavorite (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating TEXT
        );
        ''');
  }

  Future<int> insertFavorite(FavoriteTable resto) async {
    final db = await database;
    return await db!.insert(_tblFavorite, resto.toJson());
  }

  Future<int> removeFavorite(String id) async {
    final db = await database;
    return await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getFavorite() async {
    final db = await database;
    final result = await db!.query(_tblFavorite);
    if (result.isNotEmpty) {
      return result;
    }
    return [];
  }

  Future<Map<String, dynamic>?> getFavoriteById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
