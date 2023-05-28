class DbConfig {
  static const String dbName = 'transfer_arm.db';

  static final List<String> initCreateTableSql = [gameScript.createTableSql];

  /// 游戏脚本表
  static final DbMapper gameScript =
      DbMapper(tableName: 'game_script', createTableSql: '''
  CREATE TABLE IF NOT EXISTS GAME_SCRIPT (
    ID INTEGER  NOT NULL PRIMARY KEY Autoincrement,
    NAME TEXT(255) NOT NULL  
  )
  ''');
}

class DbMapper {
  String tableName;
  String createTableSql;

  DbMapper({required this.tableName, required this.createTableSql});
}
