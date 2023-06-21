import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

import 'game_script_flow.dart';

part 'game_script.g.dart';

@Entity()
@JsonSerializable(explicitToJson: true)
class GameScript {
  @Id()
  int? id;

  String name;
  List<GameScriptFlow>? flowList;

  GameScript({this.id, required this.name, this.flowList});

  static List<GameScript> fromJsonList(List dataList) {
    return dataList.map((e) => GameScript.fromJson(e)).toList();
  }

  factory GameScript.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptToJson(this);
}
