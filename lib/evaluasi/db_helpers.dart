import 'dart:async';
import 'package:p11_tugas/evaluasi/Profile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    String path = await getDatabasesPath();
    final database = openDatabase(
      join(path, 'profile.db'),
      onCreate: (database, version) async {
        await _createTable(database);
      },
      version: 1,
    );
    return database;
  }

  static Future<void> _createTable(Database db) async {
    await db.execute(
      '''
CREATE TABLE profile (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  logo TEXT,
  nama TEXT,
  ibukota TEXT,
  bupati TEXT,
  luas TEXT,
  penduduk TEXT,
  kecamatan TEXT,
  kelurahan TEXT,
  desa TEXT,
  linkweb TEXT
)
''',
    );
  }

  static Future<List<Profile>> getProfileList() async {
    final Database db = await DbHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('profile',
        orderBy: 'nama'); // Ganti 'name' dengan 'nama'
    return List.generate(maps.length, (i) {
      return Profile.fromMap(maps[i]);
    });
  }

  static Future<int> insert(Profile profile) async {
    final db = await DbHelper.db();
    int count = await db.insert(
      'profile',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return count;
  }

  static Future<int> update(Profile profile) async {
    final db = await DbHelper.db();
    int count = await db.update(
      'profile',
      profile.toMap(),
      where: 'id=?',
      whereArgs: [profile.id],
    );
    return count;
  }

  static Future<int> delete(int id) async {
    final db = await DbHelper.db();
    int count = await db.delete(
      'profile',
      where: 'id=?',
      whereArgs: [id],
    );
    return count;
  }
}
