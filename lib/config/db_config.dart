class DbConfig {
  static const String dbName = 'transfer_arm.db';

  static final List<String> initCreateTableSql = [gameScript.createTableSql, gameScriptFlow.createTableSql];

  /// 游戏脚本表
  static final DbMapper gameScript =
      DbMapper(tableName: 'game_script', createTableSql: '''
  CREATE TABLE IF NOT EXISTS game_script (
    id INTEGER  NOT NULL PRIMARY KEY Autoincrement,
    name TEXT(255) NOT NULL  
  )
  ''');

  /// 游戏脚本流程表
  static final DbMapper gameScriptFlow =
  DbMapper(tableName: 'game_script_flow', createTableSql: '''
  CREATE TABLE IF NOT EXISTS game_script_flow (
    id INTEGER  NOT NULL PRIMARY KEY Autoincrement,
    game_script_id INTEGER NOT NULL,
    order_num INTEGER NOT NULL,
    `type` TEXT(255) NOT NULL,
    `mouse_event` TEXT(255) NOT NULL,
    `axis_x` INTEGER,
    `axis_y` INTEGER,
    `axis_float` INTEGER,
    `wait_millisecond` INTEGER
  )
  ''');
}

class DbMapper {
  String tableName;
  String createTableSql;

  DbMapper({required this.tableName, required this.createTableSql});
}
