import 'dart:convert';

import 'package:common_library/utils/collection_util.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:transfer_arm/config/db_config.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';

import '../entity/common_entity.dart';

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

  /// TODO:优化，使用批处理，手动提交事务。
  Future<void> insertBatch<T>(
      {required String tableName, required List<T>? dataList}) async {
    if (CollectionUtil.isEmpty(dataList)) {
      return;
    }

    for (T data in dataList!) {
      await insert<T>(tableName: tableName, data: data);
    }
  }

  /// TODO:优化，使用批处理，手动提交事务。
  Future<void> saveBatch<T extends CommonEntity>(
      {required String tableName, required List<T> dataList}) async {
    for (var data in dataList) {
      if (data.id == null) {
        insert(tableName: tableName, data: data);
      } else {
        updateById(tableName: tableName, data: data);
      }
    }
  }

  Future<int> save<T extends CommonEntity>(
      {required String tableName, required T data}) async {
    if (data.id == null) {
      return insert(tableName: tableName, data: data);
    } else {
      updateById(tableName: tableName, data: data);
      return data.id!;
    }
  }

  Future<int> insert<T>({required String tableName, required T data}) async {
    final db = await database;
    var dataMap = jsonDecode(jsonEncode(data));
    _filterDbSupportDataType(dataMap);
    return await db.insert(tableName, dataMap);
  }

  // 示例：获取所有数据
  Future<List<T>> listAll<T>(
      {required String tableName,
      required T Function(Map<String, dynamic>? json) fromJsonT}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return fromJsonT(maps[i]);
    });
  }

  /// 根据id查询数据
  Future<T?> selectById<T>(
      {required String tableName,
      required int id,
      required T Function(Map<String, dynamic>? json) fromJsonT}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    if (CollectionUtil.isEmpty(maps)) {
      return null;
    }
    return fromJsonT(maps[0]);
  }

  // 示例：更新数据
  Future<void> updateById<T extends CommonEntity>(
      {required String tableName, required T data}) async {
    final db = await database;
    Map<String, Object?> dataMap = jsonDecode(jsonEncode(data));
    _filterDbSupportDataType(dataMap);

    await db.update(
      tableName,
      dataMap,
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  /// 过滤出数据库支持的数据类型
  void _filterDbSupportDataType(Map<String, Object?> dataMap) {
    dataMap.removeWhere((key, value) {
      return value == null ||
          !(value is int || value is num || value is String);
    });
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

  Future<void> delete({required String tableName, String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<T>?> query<T>(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
    required List<T> Function(dynamic maps) jsonToList,
  }) async {
    final db = await database;
    var maps = await db.query(DbConfig.gameScriptFlow.tableName,
        where: where, whereArgs: whereArgs);
    if (CollectionUtil.isEmpty(maps)) {
      return null;
    }

    return jsonToList(maps);
  }
}
