import 'package:life_wish/Model/LifeWish.dart';
import 'package:life_wish/db/AppDatabase.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class LifeWishDbProvider {
  Database _database;
  static const TABLE_NAME = "life_wish";

  LifeWishDbProvider() {
    _getDbObject();
  }

  _getDbObject() async {
    _database = await AppDatabase.db.database;
  }

  Future<void> insertLifeWish(LifeWish item) async {
    _database = await AppDatabase.db.database;
    await _database.insert(
      TABLE_NAME,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LifeWish>> getAllLifeWish() async {
    _database = await AppDatabase.db.database;
    // Query the table for all The LifeWish.
    final List<Map<String, dynamic>> maps = await _database.query(TABLE_NAME);
    // Convert the List<Map<String, dynamic> into a List<LifeWish>.
    return List.generate(maps.length, (i) {
      return LifeWish.fromMap(maps[i]);
    });
  }

  Future<void> updateLifeWish(LifeWish item) async {
    _database = await AppDatabase.db.database;
    // Update the given Dog.
    await _database.update(
      TABLE_NAME,
      item.toMap(),
      // fetch a matching id.
      where: "id = ?",
      // Pass the LifeWish's id as a whereArg to prevent SQL injection.
      whereArgs: [item.ID],
    );
  }

  Future<int> deleteLifeWish(String id) async {
    _database = await AppDatabase.db.database;
    // Remove the LifeWish from the Database.
    return _database.delete(
      TABLE_NAME,
      // Use a `where` clause to delete a specific record.
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
