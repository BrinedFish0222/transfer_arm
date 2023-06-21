import 'package:common_library/mapper/common_mapper.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/database_helper.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/objectbox.g.dart';

class GameScriptFlowMapper extends CommonMapper {
  /// 根据脚本id获取脚本流程
  Future<List<GameScriptFlow>?> listByGameScriptId(
      int? gameScriptId) async {
    if (gameScriptId == null) {
      return null;
    }

    return DatabaseHelper.instance.select<GameScriptFlow>(
        GameScriptFlow_.gameScriptId.equals(gameScriptId));
  }

  deleteByGameScriptId(int? gameScriptId) async {
    if (gameScriptId == null) {
      return;
    }

    var flowList = await listByGameScriptId(gameScriptId);
    if (CollectionUtil.isEmpty(flowList)) {
      return;
    }

    var deleteIds = flowList!.map((e) => e.id!).toList();
    DatabaseHelper.instance.deleteByIds(ids: deleteIds);
  }
}
