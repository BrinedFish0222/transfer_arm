import 'package:common_library/mapper/common_mapper.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/database_helper.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';

import 'game_script_flow_mapper.dart';

class GameScriptMapper extends CommonMapper {
  void saveGameScript(GameScript gameScript) {
    DatabaseHelper.instance.transaction(() {
      // 保存脚本
      LogUtil.debug('保存脚本');
      var id = DatabaseHelper.instance.save<GameScript>(data: gameScript);
      gameScript.id = id;

      // 保存脚本节点
      gameScript.flowList
          ?.forEach((element) => element.gameScriptId = gameScript.id);
      GameScriptFlowMapper().deleteByGameScriptId(gameScript.id);
      if (CollectionUtil.isNotEmpty(gameScript.flowList)) {
        DatabaseHelper.instance.saveBatch(dataList: gameScript.flowList!);
      }
    });
  }
}
