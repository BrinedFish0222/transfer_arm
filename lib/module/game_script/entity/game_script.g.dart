// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScript _$GameScriptFromJson(Map<String, dynamic> json) => GameScript(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      runNum: json['runNum'] as int?,
      flowList: (json['flowList'] as List<dynamic>?)
          ?.map((e) => GameScriptFlow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameScriptToJson(GameScript instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  writeNotNull('description', instance.description);
  writeNotNull('flowList', instance.flowList?.map((e) => e.toJson()).toList());
  writeNotNull('runNum', instance.runNum);
  return val;
}
