import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';

part 'game_script_flow.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GameScriptFlow {

  int? id;
  GameScriptFlowType type;

  MouseEvent? mouseEvent;

  int? axisX;
  int? axisY;
  /// 坐标浮动数
  int? axisFloat;
  /// 序号
  int orderNum;


  GameScriptFlow(
      {this.id,
      this.type = GameScriptFlowType.mouse,
      this.mouseEvent,
      this.axisX,
      this.axisY,
      this.axisFloat,
      this.orderNum = 1});

  static List<GameScriptFlow> fromJsonList(List dataList) {
    return dataList.map((e) => GameScriptFlow.fromJson(e)).toList();
  }

  factory GameScriptFlow.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFlowFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptFlowToJson(this);
}
