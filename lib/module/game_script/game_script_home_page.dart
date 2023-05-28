import 'dart:convert';

import 'package:common_library/constants/common_widget_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/config/router_config.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_page.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_list_widget.dart';

import 'entity/game_script.dart';
import 'model/game_script_model.dart';

class GameScriptHomePage extends StatelessWidget {
  const GameScriptHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameScriptModel>(
      create: (_) => GameScriptModel()..loadDbScriptList(),
      child: Consumer<GameScriptModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(CommonWidgetConfig.leftPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(onPressed: () => _createEvent(context: context, model: model), child: const Text("新建")),
                  const Expanded(child: GameScriptListWidget()),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  _createEvent({required BuildContext context, required GameScriptModel model}) async {
    GameScript? gameScript = await context.pushNamed<GameScript>(
        GameScriptFlowPage.routerPath,
        queryParameters: {AppRouterConfig.paramName: jsonEncode(GameScript(name: ''))});
    if (gameScript == null) {
      return;
    }

    model.dataList ??= [];
    model.dataList?.add(gameScript);
    model.notifyListeners();
  }

}


