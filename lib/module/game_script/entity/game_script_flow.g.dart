// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_script_flow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScriptFlow _$GameScriptFlowFromJson(Map<String, dynamic> json) =>
    GameScriptFlow(
      id: json['id'] as int?,
      gameScriptId: json['game_script_id'] as int?,
      type: json['type'] as String?,
      mouseEvent: json['mouse_event'] as String?,
      axisX: json['axis_x'] as int?,
      axisY: json['axis_y'] as int?,
      axisFloat: json['axis_float'] as int? ?? 5,
      orderNum: json['order_num'] as int? ?? 1,
      waitMillisecond: json['wait_millisecond'] as int?,
    );

Map<String, dynamic> _$GameScriptFlowToJson(GameScriptFlow instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('game_script_id', instance.gameScriptId);
  val['order_num'] = instance.orderNum;
  writeNotNull('type', instance.type);
  writeNotNull('mouse_event', instance.mouseEvent);
  writeNotNull('axis_x', instance.axisX);
  writeNotNull('axis_y', instance.axisY);
  writeNotNull('axis_float', instance.axisFloat);
  writeNotNull('wait_millisecond', instance.waitMillisecond);
  return val;
}
