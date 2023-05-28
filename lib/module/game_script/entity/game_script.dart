import 'package:common_library/entity/common_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'game_script_flow.dart';

part 'game_script.g.dart';

@JsonSerializable(explicitToJson: true)
class GameScript extends CommonEntity {
  String name;
  List<GameScriptFlow>? flowList;

  GameScript({super.id, required this.name, this.flowList});

  static List<GameScript> fromJsonList(List dataList) {
    return dataList.map((e) => GameScript.fromJson(e)).toList();
  }

  factory GameScript.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptToJson(this);
}
