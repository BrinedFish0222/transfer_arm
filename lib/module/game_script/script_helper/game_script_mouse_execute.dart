import 'dart:async';

import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:common_library/utils/mouse_util.dart';
import 'package:common_library/utils/random_util.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';

/// 执行脚本流程 - 鼠标操作
class GameScriptMouseExecute {
  static Future<void> run(GameScriptFlow flow) async {
    if (flow.type != GameScriptFlowType.mouse.name) {
      return;
    }

    flow.axisFloat ??= 0;

    bool plusSign = RandomUtil.isPlusSign();
    int axisFloatX = RandomUtil.nextInt(0, flow.axisFloat!);
    int axisFloatY = RandomUtil.nextInt(0, flow.axisFloat!);

    int x = plusSign ? flow.axisX! + axisFloatX : flow.axisX! - axisFloatX;
    int y = plusSign ? flow.axisY! + axisFloatY : flow.axisY! - axisFloatY;

    LogUtil.debug('脚本执行 - 鼠标点击，x轴：$x，y轴：$y');
    await MouseUtil.mouseMove(x: x, y: y);
    await MouseUtil.mouseClick(
        mouseEvent: flow.mouseEvent == null
            ? MouseEvent.leftClick
            : MouseEvent.getByName(flow.mouseEvent));
  }
}
