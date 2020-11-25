import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database _database;

  AppDatabase._();

  static final AppDatabase db = AppDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "lifeWish.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.transaction((txn) async {
        await txn.execute("CREATE TABLE life_wish ("
            "id TEXT PRIMARY KEY,"
            "msg_to TEXT,"
            "subject TEXT,"
            "is_scheduled BIT,"
            "scheduled_time TEXT,"
            "msg_body TEXT,"
            "msg_formatting TEXT,"
            "msg_type INTEGER," // DRAFT = 1, SENT = 2, RECEIVED = 3
            "created_on TEXT,"
            "modified_on TEXT"
            ")");

        await txn.execute("CREATE TABLE life_wish_media ("
            "id INTEGER PRIMARY KEY,"
            "msg_id TEXT,"
            "media_type INTEGER," // IMAGE = 1, VIDEO = 2, SOUND = 3
            "media_link TEXT,"
            "created_on TEXT,"
            "modified_on TEXT"
            ")");
      });
    });
  }
}
