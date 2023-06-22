
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/script_helper/game_script_wait_execute.dart';

import '../constants/game_script_flow_type.dart';
import 'entity/game_script_helper_run.dart';
import 'game_script_mouse_execute.dart';

class GameScriptHelper {

  static final GameScriptHelper _instance = GameScriptHelper._internal();

  // 私有的命名构造函数
  GameScriptHelper._internal();

  factory GameScriptHelper.getInstance() {
    return _instance;
  }

  bool _isRun = false;

  Stream<GameScriptHelperRun> run(GameScript? gameScript) async* {
    LogUtil.debug('脚本运行准备阶段');
    if (gameScript == null || CollectionUtil.isEmpty(gameScript.flowList)) {
      throw Exception('缺少脚本数据，结束运行');
    }

    _isRun = true;

    LogUtil.debug('脚本开始运行');
    // 运行次数
    int runningNum = 0;
    while(gameScript.runNum == null ? true : runningNum <= gameScript.runNum!) {
      if (!_isRun) {
        return;
      }

      for (GameScriptFlow flow in gameScript.flowList!) {

        if (flow.type == GameScriptFlowType.wait.name) {
          await GameScriptWaitExecute.run(flow);
        } else if (flow.type == GameScriptFlowType.mouse.name) {
          await GameScriptMouseExecute.run(flow);
        }
      }

      runningNum += 1;
      LogUtil.info('脚本运行$runningNum次，剩余次数：${gameScript.runNum! - runningNum}');

      yield GameScriptHelperRun(runningNum: runningNum, isStop: runningNum > gameScript.runNum!);
    }
  }

  void stop() {
    _isRun = false;
  }

}
