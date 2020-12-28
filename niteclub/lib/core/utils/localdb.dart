import 'dart:async';
import 'package:sqflite/sqflite.dart';
//import 'package:niteclub/core/models/place_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class localDatabase {
  Database _db;

  initDB(sql,db) async {
    _db = await openDatabase(
      db,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(sql);
      },
    );
    print("Database Done!");
  }

  insert_db(String table, Map<String, dynamic> map) async {
    if (_db != null){
      await deleteAllEmployees(table);
    }
    final db = await _db;
    db.insert(table, map);
  }

  Future<int> deleteAllEmployees(String table) async {
    final Database db = await _db;
    final res = await db.delete('DELETE FROM ${table}');

    return res;
  }

}