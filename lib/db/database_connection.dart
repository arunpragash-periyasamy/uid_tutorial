import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class DatabaseConnection {
  static const String notesusers =
      "CREATE TABLE IF NOT EXISTS users_table(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT NOT NULL,contact TEXT NOT NULL,description TEXT NOT NULL)";

  /// Opening database
  static Future<sql.Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, "users.db"),
      onCreate: (db, version) {
        db.execute(notesusers);
      },
      version: 1,
    );
  }

  static Future<int> addUser(Map<String, dynamic> data) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database
    debugPrint('SHOW INSERTED RECORD DETAILS: $data');
    return db.insert(
      "users_table", data, //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  static Future<List<User>> fetchMemos() async {
    final db = await init();
    var res = await db.query("users_table");
    if (kDebugMode) {
      print('SHOW PRODUCTS TABLE OFFLINE RECORDS: $res');
    }
    if (kDebugMode) {
      print('SHOW PRODUCTS TABLE OFFLINE RECORDS: ${res.length}');
    }
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  static Future<int> deleteMemo(int id) async {
    //returns number of items deleted
    final db = await init();
    int result = await db.delete("users_table", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }

  static Future<void> updateQuantity(
      int id, String name, String contact, String description) async {
    final db = await DatabaseConnection.init();
    await db.rawUpdate(
      "UPDATE users_table SET name = '$name', contact = '$contact', description = '$description' WHERE id = '$id' ",
    );
  }

  static close() async {
    final db = await DatabaseConnection.init();
    db.close();
  }
}
