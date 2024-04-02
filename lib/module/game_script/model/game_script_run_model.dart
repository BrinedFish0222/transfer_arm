import 'package:common_library/model/view_state_model.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';

import '../mapper/game_script_flow_mapper.dart';
import '../script_helper/game_script_helper.dart';

/// 脚本运行模式
class GameScriptRunModel extends ViewStateModel {
  /// 当前运行的脚本
  GameScript? runGameScript;

  /// 已运行次数
  int runningNum = 0;

  set setRunningNum(int setRunningNum) {
    LogUtil.debug('接收的已运行次数：$setRunningNum');
    runningNum = setRunningNum;
    notifyListeners();
  }

  /// 运行脚本
  void start(GameScript gameScript) async {
    runGameScript = gameScript;
    notifyListeners();

    runGameScript?.flowList = GameScriptFlowMapper().listByGameScriptId(runGameScript!.id!);

    await Future.delayed(const Duration(seconds: 3));
    GameScriptHelper.getInstance().run(runGameScript).listen((event) {
      LogUtil.debug('脚本监听回调');
      setRunningNum = event.runningNum;
      if (event.isStop) {
        stop();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  /// 停止运行脚本
  void stop() {
    LogUtil.debug("结束脚本");
    GameScriptHelper.getInstance().stop();
    runGameScript = null;
    runningNum = 0;
    notifyListeners();
  }
}
