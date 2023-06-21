import 'package:common_library/model/common_model.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/mapper/game_script_flow_mapper.dart';
import 'package:transfer_arm/module/game_script/mapper/game_script_mapper.dart';
import 'package:transfer_arm/module/game_script/script_helper/game_script_helper.dart';

import '../entity/game_script.dart';

class GameScriptModel extends CommonModel<GameScript> {
  GameScriptModel({super.data});

  /// 脚本运行状态
  bool scriptRunStatus = false;

  /// 改变脚本运行状态
  void changeScriptRunStatus({bool? status}) async {
    scriptRunStatus = status ?? !scriptRunStatus;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    if (scriptRunStatus) {
      await loadScript();
      GameScriptHelper.getInstance().run(data).onError((error, stackTrace) {
        LogUtil.debug(error.toString());
        scriptRunStatus = !scriptRunStatus;
      });
    } else {
      GameScriptHelper.getInstance().stop();
    }
    notifyListeners();
  }

  loadScript() async {
    if (data == null || data?.id == null) {
      return;
    }

    setBusy();
    data = await GameScriptMapper().selectById<GameScript>(data!.id!);
    data?.flowList = await GameScriptFlowMapper().listByGameScriptId(data?.id);
    setIdle();
  }

  /// 加载数据库脚本数据
  loadScriptList() async {
    dataList = await GameScriptMapper().listAll<GameScript>();
    notifyListeners();
  }

  void deleteById(int? id) async {
    if (id == null) {
      return;
    }

    await GameScriptMapper().deleteById<GameScript>(id);
    if (CollectionUtil.isNotEmpty(dataList)) {
      dataList?.removeWhere((element) => element.id == id);
    }

    notifyListeners();
  }

  void deleteFlow(GameScriptFlow flow) {
    data?.flowList?.remove(flow);
    notifyListeners();
  }

  void save() {
    GameScriptMapper().saveGameScript(data!);
  }
}
