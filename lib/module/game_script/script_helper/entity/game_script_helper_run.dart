import 'package:json_annotation/json_annotation.dart';

part 'GameScriptHelperRun.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GameScriptHelperRun {
  
  
  static List<GameScriptHelperRun> fromJsonList(List dataList) {
    return dataList.map((e) => GameScriptHelperRun.fromJson(e)).toList();
  }

  factory GameScriptHelperRun.fromJson(Map<String, dynamic> json) =>
      _$GameScriptHelperRunFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptHelperRunToJson(this);
}
