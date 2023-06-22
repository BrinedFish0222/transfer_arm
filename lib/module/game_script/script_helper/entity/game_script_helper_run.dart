import 'package:json_annotation/json_annotation.dart';

part 'game_script_helper_run.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GameScriptHelperRun {
  GameScriptHelperRun({this.runningNum = 0, this.isStop = false});

  /// 运行次数
  int runningNum;

  /// 是否结束
  bool isStop;

  static List<GameScriptHelperRun> fromJsonList(List dataList) {
    return dataList.map((e) => GameScriptHelperRun.fromJson(e)).toList();
  }

  factory GameScriptHelperRun.fromJson(Map<String, dynamic> json) =>
      _$GameScriptHelperRunFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptHelperRunToJson(this);
}
