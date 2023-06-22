import 'package:common_library/constants/common_widget_config.dart';
import 'package:common_library/utils/collection_util.dart';
import 'package:common_library/utils/confirm_dialog_utils.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:common_library/widget/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/game_script_model.dart';
import '../model/game_script_run_model.dart';
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
    GameScriptListModel gameScriptModel = context.watch<GameScriptListModel>();
    GameScriptRunModel gameScriptRunModel = context.watch<GameScriptRunModel>();

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
            LogUtil.debug('按下空格');
            // 处理空格键按下事件
            gameScriptRunModel.stop();
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.all(CommonWidgetConfig.leftPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: CommonWidgetConfig.lineHeight,
            ),
            Expanded(
                child: CollectionUtil.isEmpty(gameScriptModel.dataList)
                    ? const SizedBox()
                    : ListView(
                        children: gameScriptModel.dataList
                            .map((gameScript) => Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                            '${gameScript.name}-${gameScript.runNum ?? '无限'}')),
                                    Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () {
                                              if (gameScriptRunModel
                                                      .runGameScript !=
                                                  null) {
                                                gameScriptRunModel.stop();
                                                return;
                                              }

                                              gameScriptRunModel
                                                  .start(gameScript);
                                            },
                                            icon: Icon(gameScriptRunModel
                                                        .runGameScript?.id ==
                                                    gameScript.id
                                                ? AppIcons.stop
                                                : AppIcons.start))),
                                    Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () async {
                                              gameScriptModel.editGameScript =
                                                  gameScript;
                                              await gameScriptModel
                                                  .loadEditGameScript();
                                              if (!mounted) {
                                                return;
                                              }
                                              context.push(GameScriptFlowPage
                                                  .routerPath);
                                            },
                                            icon: const Icon(AppIcons.edit))),
                                    Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () async {
                                              bool isDel =
                                                  await ConfirmDialogUtils
                                                      .isDeleteDialog(context);
                                              if (!isDel) {
                                                return;
                                              }
                                              gameScriptModel
                                                  .deleteById(gameScript.id);
                                            },
                                            icon: const Icon(AppIcons.delete))),
                                  ],
                                ))
                            .toList(),
                      )),
          ],
        ),
      ),
    );
  }
}
