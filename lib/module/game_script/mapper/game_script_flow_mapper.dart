import 'package:common_library/utils/database_helper.dart';
import 'package:transfer_arm/config/db_config.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';

class GameScriptFlowMapper {
  static final String _tableName = DbConfig.gameScriptFlow.tableName;

  /// 根据脚本id获取脚本流程
  static Future<List<GameScriptFlow>?> listByGameScriptId(
      int? gameScriptId) async {
    if (gameScriptId == null) {
      return null;
    }

    return DatabaseHelper.internal().query(_tableName,
        where: "game_script_id = ?",
        whereArgs: [gameScriptId],
        jsonToList: (maps) => GameScriptFlow.fromJsonList(maps));
  }

  static void deleteById(int? id) async {
    if (id == null) {
      return;
    }

    await DatabaseHelper.internal().deleteById(tableName: _tableName, id: id);
  }

  static deleteByGameScriptId(int? gameScriptId) async {
    if (gameScriptId == null) {
      return;
    }

    await DatabaseHelper.internal().delete(tableName: _tableName, where: "game_script_id = ?", whereArgs: [gameScriptId]);
  }
}
