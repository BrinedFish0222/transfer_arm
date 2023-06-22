import 'package:common_library/mapper/common_mapper.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/database_helper.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/objectbox.g.dart';

class GameScriptFlowMapper extends CommonMapper {
  /// 根据脚本id获取脚本流程
  List<GameScriptFlow>? listByGameScriptId(int? gameScriptId) {
    if (gameScriptId == null) {
      return null;
    }

    var result = DatabaseHelper.instance.select<GameScriptFlow>(
        GameScriptFlow_.gameScriptId.equals(gameScriptId));


    LogUtil.debug('加载脚本id：$gameScriptId, 脚本数量：${result.length}');
    
    return result;
  }

  void deleteByGameScriptId(int? gameScriptId) {
    if (gameScriptId == null) {
      return;
    }

    var flowList = listByGameScriptId(gameScriptId);
    if (CollectionUtil.isEmpty(flowList)) {
      return;
    }

    var deleteIds = flowList!.map((e) => e.id!).toList();
    DatabaseHelper.instance.deleteByIds<GameScriptFlow>(ids: deleteIds);
  }
}
