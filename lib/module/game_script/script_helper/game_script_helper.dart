
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/script_helper/game_script_wait_execute.dart';

import 'game_script_mouse_execute.dart';

class GameScriptHelper {

  static final GameScriptHelper _instance = GameScriptHelper._internal();

  // 私有的命名构造函数
  GameScriptHelper._internal();

  factory GameScriptHelper.getInstance() {
    return _instance;
  }

  bool _isRun = false;

  Future<void> run(GameScript? gameScript) async {
    LogUtil.debug('脚本运行准备阶段');
    if (gameScript == null || CollectionUtil.isEmpty(gameScript.flowList)) {
      throw Exception('缺少脚本数据，结束运行');
    }

    _isRun = true;

    LogUtil.debug('脚本开始运行');
    while(true) {
      if (!_isRun) {
        return;
      }

      for (GameScriptFlow flow in gameScript.flowList!) {
        await GameScriptWaitExecute.run(flow);
        await GameScriptMouseExecute.run(flow);
      }
    }
  }

  void stop() {
    _isRun = false;
  }

}
