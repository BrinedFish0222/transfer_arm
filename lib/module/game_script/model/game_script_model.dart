import 'package:common_library/model/view_state_model.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/mapper/game_script_flow_mapper.dart';
import 'package:transfer_arm/module/game_script/mapper/game_script_mapper.dart';

import '../entity/game_script.dart';

/// 脚本列表
class GameScriptListModel extends ViewStateModel {
  /// 数据列表
  List<GameScript> dataList = [];

  /// 当前编辑的脚本
  GameScript? editGameScript;

  /// 加载数据库脚本数据
  void loadScriptList() {
    dataList = GameScriptMapper().listAll<GameScript>();
    notifyListeners();
  }

  void deleteById(int? id) {
    if (id == null) {
      return;
    }

    GameScriptMapper().deleteById<GameScript>(id);
    if (CollectionUtil.isNotEmpty(dataList)) {
      dataList.removeWhere((element) => element.id == id);
    }

    notifyListeners();
  }

  Future<void> deleteEditGameScriptFlow(GameScriptFlow flow) async {
    editGameScript?.flowList?.remove(flow);
    notifyListeners();
  }

  Future<void> saveEditGameScript() async {
    GameScriptMapper().saveGameScript(editGameScript!);
    dataList.removeWhere((element) => element.id == editGameScript?.id);
    dataList.insert(0, editGameScript!);
    notifyListeners();
  }

  Future<void> loadEditGameScript() async {
    editGameScript!.flowList =
        GameScriptFlowMapper().listByGameScriptId(editGameScript!.id!);

    notifyListeners();
  }
}
