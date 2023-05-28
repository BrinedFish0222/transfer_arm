import 'package:common_library/entity/common_entity.dart';
import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';

part 'game_script_flow.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GameScriptFlow extends CommonEntity {
  int? gameScriptId;

  /// 序号
  int orderNum;
  GameScriptFlowType type;

  MouseEvent? mouseEvent;

  int? axisX;
  int? axisY;

  /// 坐标浮动数
  int? axisFloat;

  /// 等待毫秒值
  int? waitMillisecond;

  GameScriptFlow(
      {super.id,
      this.gameScriptId,
      this.type = GameScriptFlowType.mouse,
      this.mouseEvent = MouseEvent.leftClick,
      this.axisX,
      this.axisY,
      this.axisFloat,
      this.orderNum = 1,
      this.waitMillisecond});

  static List<GameScriptFlow> fromJsonList(List dataList) {
    return dataList.map((e) => GameScriptFlow.fromJson(e)).toList();
  }

  factory GameScriptFlow.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFlowFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptFlowToJson(this);
}
