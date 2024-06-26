import 'package:common_library/constants/common_widget_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_page.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_list_widget.dart';

import 'entity/game_script.dart';
import 'model/game_script_model.dart';
import 'model/game_script_run_model.dart';

class GameScriptHomePage extends StatelessWidget {
  const GameScriptHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameScriptListModel gameScriptModel = context.watch<GameScriptListModel>();
    GameScriptRunModel gameScriptRunModel = context.watch<GameScriptRunModel>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(CommonWidgetConfig.leftPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: () => _createEvent(context: context, model: gameScriptModel), child: const Text("新建")),
                SizedBox(width: CommonWidgetConfig.weight,),
                const Expanded(child: Text('想暂停脚本，切回软件界面，按下空格即可', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),))
              ],
            ),
            if (gameScriptRunModel.runGameScript != null)
              Text('执行次数：${gameScriptRunModel.runningNum}'),
            const Expanded(child: GameScriptListWidget()),
          ],
        ),
      ),
    );
  }

  _createEvent({required BuildContext context, required GameScriptListModel model}) async {
    model.editGameScript = GameScript(name: '');
    context.push<GameScript>(GameScriptFlowPage.routerPath);
  }

}


