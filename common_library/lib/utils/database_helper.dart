import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:transfer_arm/config/db_config.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_common/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    sqflite_ffi.sqfliteFfiInit();

    // Initialize databaseFactory
    databaseFactory = databaseFactoryFfi;

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DbConfig.dbName);

    // 创建数据库表或打开现有数据库
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // 在此处创建表
        for (String sql in DbConfig.initCreateTableSql) {
          db.execute(sql);
        }
      },
    );

    return database;
  }

  // 示例：插入数据
  Future<void> insert<T>({required String tableName, required T data}) async {
    final db = await database;
    await db.insert(tableName, data as Map<String, Object?>);
  }

  // 示例：获取所有数据
  Future<List<T>> listAll<T>({required String tableName}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return jsonDecode(jsonEncode(maps[i]));
    });
  }

  // 示例：更新数据
  Future<void> updateById<T>(
      {required String tableName, required T data}) async {
    final db = await database;
    var dataMap = jsonDecode(jsonEncode(data));
    await db.update(
      tableName,
      dataMap,
      where: 'id = ?',
      whereArgs: [dataMap['id']],
    );
  }

  // 示例：删除数据
  Future<void> deleteById({required String tableName, required int id}) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
