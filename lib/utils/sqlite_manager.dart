import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task_model.dart';

/// Manages all the Sqlite operations on the database
class SqliteManager extends ChangeNotifier {
  static final String _dbName = 'tasks.db';
  Database db;

  SqliteManager() {
    initDB();
  }

  void initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    db = await openDatabase(path, version: 1, onOpen: (db) {
      //update Database
      //according to time
    }, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Tasks (id TEXT PRIMARY KEY,title TEXT,details TEXT,deadlineDate TEXT,taskType TEXT);');
    });
    notifyListeners();
  }

  void insertTaskToDb(TaskModel taskModel) async {
    await db.insert(
      "Tasks",
      taskModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  void removeTaskById(TaskModel taskModel) async {
    await db.delete(
      "Tasks",
      where: "id = ?",
      whereArgs: [taskModel.id],
    );
    notifyListeners();
  }

  void updateTaskInDb(TaskModel taskModel, {notify = true}) async {
    await db.update(
      "Tasks",
      taskModel.toJson(),
      where: "id = ?",
      whereArgs: [taskModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (notify) notifyListeners();
  }

  Future<List<TaskModel>> getTasksfromDb(TaskType tp) async {
    var res = await db.query(
      "Tasks",
      distinct: true,
      where: "taskType = ?",
      whereArgs: [tp.toString().substring(9)],
      orderBy: "deadlineDate ASC",
    );
    List<TaskModel> list = res.isNotEmpty
        ? res.map((tm) => TaskModel.fromJson(tm)).toList()
        : null;
    return list;
  }
}
