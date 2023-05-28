import 'package:common_library/model/common_model.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/database_helper.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/config/db_config.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/mapper/game_script_flow_mapper.dart';
import 'package:transfer_arm/module/game_script/script_helper/game_script_helper.dart';

import '../entity/game_script.dart';

class GameScriptModel extends CommonModel<GameScript> {
  GameScriptModel({super.data});

  final String _tableName = DbConfig.gameScript.tableName;

  /// 脚本运行状态
  bool scriptRunStatus = false;

  /// 改变脚本运行状态
  void changeScriptRunStatus({bool? status}) async {
    scriptRunStatus = status ?? !scriptRunStatus;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    if (scriptRunStatus) {
      await loadDbScript();
      GameScriptHelper.getInstance().run(data).onError((error, stackTrace) {
        LogUtil.debug(error.toString());
        scriptRunStatus = !scriptRunStatus;
      });
    } else {
      GameScriptHelper.getInstance().stop();
    }
    notifyListeners();
  }

  /// 存储脚本数据到数据库
  void saveGameScriptDb() async {
    if (data == null) {
      return;
    }

    var gameScriptId = await DatabaseHelper.internal()
        .save(tableName: _tableName, data: data!);
    data?.id = gameScriptId;
    refreshFlowParentId();

    await GameScriptFlowMapper.deleteByGameScriptId(data?.id);

    if (CollectionUtil.isNotEmpty(data?.flowList)) {
      DatabaseHelper.internal().insertBatch(
          tableName: DbConfig.gameScriptFlow.tableName,
          dataList: data!.flowList!);
    }

    notifyListeners();
  }

  void refreshFlowParentId() {
    data?.flowList?.forEach((element) => element.gameScriptId = data?.id);
  }

  loadDbScript() async {
    if (data == null || data?.id == null) {
      return;
    }

    data = await DatabaseHelper.internal()
        .selectById<GameScript>(
            tableName: _tableName,
            id: data!.id!,
            fromJsonT: (json) => GameScript.fromJson(json!));

    data?.flowList = await GameScriptFlowMapper.listByGameScriptId(data?.id);
    notifyListeners();
  }

  /// 加载数据库脚本数据
  loadDbScriptList() async {
    dataList = await DatabaseHelper.internal().listAll<GameScript>(
        tableName: _tableName, fromJsonT: (obj) => GameScript.fromJson(obj!));
    notifyListeners();
  }

  void deleteById(int? id) async {
    if (id == null) {
      return;
    }

    await DatabaseHelper.internal().deleteById(tableName: _tableName, id: id);
    if (CollectionUtil.isNotEmpty(dataList)) {
      dataList?.removeWhere((element) => element.id == id);
    }

    notifyListeners();
  }

  void deleteFlow(GameScriptFlow flow) {
    data?.flowList?.remove(flow);
    notifyListeners();
  }
}
