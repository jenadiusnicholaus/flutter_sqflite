import 'package:sqflite/sqflite.dart';
import 'package:flutter_crud/data/model.dart';
import 'package:flutter_crud/data/database.dart';

class CRUDS {
  static Future<int> addItem(
      {MemoModel? item, Database? db, String? tableName}) async {
    try {
      var q = await db!.insert(
        tableName!,
        item!.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return q;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<MemoModel?>> fetchMemos({String? tableName}) async {
    var db = await DatabaseHelper.instance.database;

    final maps = await db.query(tableName!, orderBy: '-id');

    return List.generate(maps.length, (i) {
      if (maps.isNotEmpty) {
        return MemoModel.toJson(maps[i]);
      }
    });
  }

  static Future<int> deleteMemo(
      {int? id, Database? db, String? tableName}) async {
    int result = await db!.delete(tableName!, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<int> updateMemo(
      {int? id, MemoModel? item, Database? db, String? tableName}) async {
    int result = await db!
        .update(tableName!, item!.toMap(), where: "id = ?", whereArgs: [id]);

    return result;
  }
}
