import 'package:json_annotation/json_annotation.dart';

part 'game_script.g.dart';

@JsonSerializable(explicitToJson: true)
class GameScript {

  int? id;
  String name;

  GameScript({this.id, required this.name});

  static List<GameScript> fromJsonList(List dataList) {
    return dataList.map((e) => GameScript.fromJson(e)).toList();
  }

  factory GameScript.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptToJson(this);
}
