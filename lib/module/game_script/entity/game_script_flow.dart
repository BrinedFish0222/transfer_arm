import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';

part 'game_script_flow.g.dart';

@Entity()
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class GameScriptFlow {
  @Id()
  int? id;

  int? gameScriptId;

  /// 序号
  int orderNum;

  /// GameScriptFlowType
  String? type;

  /// MouseEvent
  String? mouseEvent;

  int? axisX;
  int? axisY;

  /// 坐标浮动数 / 浮动数
  int? axisFloat;

  /// 等待毫秒值
  int? waitMillisecond;

  GameScriptFlow(
      {this.id,
      this.gameScriptId,
      String? type,
      String? mouseEvent,
      this.axisX,
      this.axisY,
      this.axisFloat = 5,
      this.orderNum = 1,
      this.waitMillisecond}) {
    this.type = type ?? GameScriptFlowType.mouse.name;
    this.mouseEvent = mouseEvent ?? MouseEvent.leftClick.name;
  }

  static List<GameScriptFlow> fromJsonList(List dataList) {
    return dataList.map((e) => GameScriptFlow.fromJson(e)).toList();
  }

  factory GameScriptFlow.fromJson(Map<String, dynamic> json) =>
      _$GameScriptFlowFromJson(json);

  Map<String, dynamic> toJson() => _$GameScriptFlowToJson(this);

  void waitTypeClear() {
    if (type != GameScriptFlowType.wait.name) {
      return;
    }

    mouseEvent = null;
    axisX = null;
    axisY = null;
  }
}
