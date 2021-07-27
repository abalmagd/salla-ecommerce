import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static Database _database;

  static Future<Database> dbInit() async {
    return await openDatabase(
      'salla_search.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute('CREATE TABLE Search (id INTEGER PRIMARY KEY, query TEXT)')
            .then((value) => debugPrint('Database created'))
            .catchError((error) => print(error));
      },
      onOpen: (db) async {
        debugPrint('Database Opened');
        dbGet(db: db);
      },
    ).then((value) {
      _database = value;
    }).catchError((error) {
      debugPrint('Error in dbInit() => $error');
    });
  }

  static Future<List> dbGet({Database db}) async {
    if (db == null)
      return await _database.rawQuery('SELECT * FROM Search');
    else
      return await db.rawQuery('SELECT * FROM Search');
  }

  static Future<void> dbInsert(String searchQuery) async {
    await _database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO Search(query) VALUES(?)', [searchQuery]);
    });
  }

  static Future<int> dbDelete(int id) async =>
      await _database.rawDelete('DELETE FROM Search WHERE id = ?', [id]);

  static Future<int> dbClear() async => await _database.rawDelete('DELETE FROM Search');

  static void dbClose() {
    debugPrint('Database closed');
    _database.close();
  }
}
