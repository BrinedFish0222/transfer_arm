// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScript _$GameScriptFromJson(Map<String, dynamic> json) => GameScript(
      id: json['id'] as int?,
      name: json['name'] as String,
      flowList: (json['flow_list'] as List<dynamic>?)
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
  writeNotNull('flow_list', instance.flowList?.map((e) => e.toJson()).toList());
  return val;
}
