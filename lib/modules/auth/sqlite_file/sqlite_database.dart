import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'contact.db';
  static const table = 'contact_table';
  static const columnId = 'id';
  static const phoneNumber = 'number';

  DatabaseHelper._databaseHelper();

  static final DatabaseHelper instance = DatabaseHelper._databaseHelper();

  static Database? database;

  Future<Database> get databaseGet async {
    if (database != null) return database!;
    database = await initDatabase();
    return database!;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    return await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $phoneNumber TEXT NOT NULL
             )
          ''');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    Database db = await instance.databaseGet;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.databaseGet;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> newData, String oldNumber) async {
    Database db = await instance.databaseGet;
    return await db.update(table, newData, where: '$phoneNumber = ?', whereArgs: [oldNumber]);
  }

  Future delete(String number) async {
    Database db = await instance.databaseGet;
    return await db.delete(table, where: '$phoneNumber = ?', whereArgs: [number]);
  }

  Future<bool> checkFavorite(number) async {
    Database db = await instance.databaseGet;
    String qry = "select * from $table where $phoneNumber = '$number'";
    List check = await db.rawQuery(qry);
    bool checkIdRepeated = false;
    if (check.isNotEmpty) {
      checkIdRepeated = true;
    }
    return checkIdRepeated;
  }
}
