import 'package:common_library/constants/common_widget_config.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/widget/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../entity/game_script.dart';
import '../model/game_script_model.dart';
import 'game_script_flow_page.dart';

/// 脚本列表
class GameScriptListWidget extends StatefulWidget {
  const GameScriptListWidget({Key? key}) : super(key: key);

  @override
  State<GameScriptListWidget> createState() => _GameScriptListWidgetState();
}

class _GameScriptListWidgetState extends State<GameScriptListWidget> {


  @override
  Widget build(BuildContext context) {
    return Consumer<GameScriptModel>(
      builder: (context, model, _) {
        return Padding(
          padding: EdgeInsets.all(CommonWidgetConfig.leftPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: CommonWidgetConfig.lineHeight,
              ),
              Expanded(
                  child: CollectionUtil.isEmpty(model.dataList) ? const SizedBox() : ListView(
                children: model.dataList
                    !.map((gameScript) => Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(flex: 6, child: Text(gameScript.name)),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(AppIcons.start))),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                    onPressed: () async {
                                      await context.pushNamed<GameScript>(
                                          GameScriptFlowPage.routerPath,
                                          queryParameters: gameScript.toJson());
                                    },
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
    );
  }


}