// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String? path;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    path = join(documentsDirectory.path, 'mysql.db');
    return await openDatabase(path!, version: 3,
        onCreate: (Database db, int version) async {
      await db.execute('''
              CREATE TABLE Tasks (
                id TEXT ,
                todo TEXT ,
                completed TEXT ,
                userId INTEGER 
              )
              ''');
    });
  }

  insert(element) async {
    final Database db = await initDatabase();

    await db.insert(
      'Tasks',
      element,
    );
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final Database db = await initDatabase();

    return await db.rawQuery('SELECT * FROM Tasks');
  }

  Future deleteTask(id) async {
    final Database db = await initDatabase();

    await db.rawQuery('DELETE FROM Tasks where id=$id');
  }

  Future updateTask(id, completed) async {
    final Database db = await initDatabase();

    await db.rawUpdate('UPDATE Tasks SET completed = ? WHERE id = ?',
        [completed.toString(), id.toString()]);
  }
}
