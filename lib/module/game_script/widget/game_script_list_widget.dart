import 'package:common_library/widget/app_icons.dart';
import 'package:common_library/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_page.dart';

import '../entity/game_script.dart';
import '../model/game_scripts.dart';

/// 脚本列表
class GameScriptListWidget extends StatefulWidget {
  const GameScriptListWidget({Key? key}) : super(key: key);

  @override
  State<GameScriptListWidget> createState() => _GameScriptListWidgetState();
}

class _GameScriptListWidgetState extends State<GameScriptListWidget>
    with CommonWidget {
  late GameScriptModel _gameScriptModel;

  @override
  Widget build(BuildContext context) {
    _gameScriptModel = context.watch<GameScriptModel>();
    return Padding(
      padding: EdgeInsets.all(defaultLeftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: _createEvent, child: const Text("新建")),
          SizedBox(
            height: defaultLineHeight,
          ),
          Expanded(
              child: ListView(
            children: _gameScriptModel.dataList
                .map((e) => Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(flex: 6, child: Text(e.name)),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(AppIcons.start))),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(AppIcons.edit))),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(AppIcons.delete))),
                      ],
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }

  _createEvent() async {
    GameScript? gameScript = await context.pushNamed<GameScript>(
        GameScriptFlowPage.routerPath,
        queryParameters: GameScript(name: '', flowList: []).toJson());
    if (gameScript == null) {
      return;
    }

    _gameScriptModel.dataList.add(gameScript);
    _gameScriptModel.notifyListeners();
  }
}
