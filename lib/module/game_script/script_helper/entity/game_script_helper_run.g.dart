// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_script_helper_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScriptHelperRun _$GameScriptHelperRunFromJson(Map<String, dynamic> json) =>
    GameScriptHelperRun(
      runningNum: json['running_num'] as int? ?? 0,
      isStop: json['is_stop'] as bool? ?? false,
    );

Map<String, dynamic> _$GameScriptHelperRunToJson(
        GameScriptHelperRun instance) =>
    <String, dynamic>{
      'running_num': instance.runningNum,
      'is_stop': instance.isStop,
    };
