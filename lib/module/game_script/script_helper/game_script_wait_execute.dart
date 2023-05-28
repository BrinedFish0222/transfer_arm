

import 'dart:async';

import 'package:common_library/utils/log_util.dart';
import 'package:common_library/utils/random_util.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';

/// 执行脚本流程 - 等待
class GameScriptWaitExecute {

  static Future<void> run(GameScriptFlow flow) async {
    if (flow.type != GameScriptFlowType.wait) {
      return;
    }

    flow.axisFloat ??= 0;

    bool plusSign = RandomUtil.isPlusSign();
    int waitMillisecond = plusSign ? flow.waitMillisecond! + flow.axisFloat! : flow.waitMillisecond! - flow.axisFloat!;

    LogUtil.debug('脚本执行 - 等待$waitMillisecond毫秒');
    await Future.delayed(Duration(milliseconds: waitMillisecond), () {});
  }

}
