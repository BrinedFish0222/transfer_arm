import 'package:common_library/constants/input_formats.dart';
import 'package:common_library/utils/confirm_dialog_utils.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:common_library/widget/app_text_field.dart';
import 'package:common_library/widget/common_widget.dart';
import 'package:common_library/widget/common_widget_utils.dart';
import 'package:common_library/widget/text_not_null_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';
import 'package:transfer_arm/module/game_script/model/game_scripts.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_edit_widget.dart';

import '../../../themes/app_theme.dart';

class GameScriptFlowPage extends StatefulWidget {
  const GameScriptFlowPage({
    Key? key,
    required this.gameScript,
  }) : super(key: key);

  static const String routerPath = "/gameScript/flowPage";

  final GameScript gameScript;

  @override
  State<GameScriptFlowPage> createState() => _GameScriptFlowPageState();
}

class _GameScriptFlowPageState extends State<GameScriptFlowPage>
    with CommonWidget {

  late GameScriptModel _gameScriptModel;

  @override
  Widget build(BuildContext context) {
    _gameScriptModel = GameScriptModel();
    _gameScriptModel.data = widget.gameScript;
    return ChangeNotifierProvider<GameScriptModel>.value(
      value: _gameScriptModel,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: _backEvent,
          ),
          title: const Text("脚本流程"),
          actions: [
            TextButton(
                onPressed: _saveEvent,
                child: Text(
                  '保存',
                  style: TextStyle(color: AppTheme.appBarBtnColor),
                ))
          ],
        ),
        body: Form(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildName(context),
              ),
              SliverStickyHeader(
                header: Container(
                  height: 60.0,
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: _buildTitle(),
                ),
                sliver: SliverReorderableList(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      key: ValueKey(index),
                      leading: const CircleAvatar(
                        child: Text('0'),
                      ),
                      title: Text('List tile #$index'),
                    );
                }, itemCount: 40, onReorder: (int oldIndex, int newIndex) {

                },
                ),
              )
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: _buildAddScriptFlow, child: const Icon(Icons.add)),
      ),
    );
  }

  _buildAddScriptFlow() async {
    await CommonWidgetUtils.buildBottomSheet(context: context, child: GameScriptFlowEditWidget());
  }

  _backEvent() async {
    bool isBack = await ConfirmDialogUtils.isSaveDialog(context);
    if (!mounted) return;
    LogUtil.debug('isBack: $isBack');
    if (isBack) {
      _saveEvent();
      context.pop(widget.gameScript);
      return;
    }
    context.pop();
  }

  _saveEvent() {
    LogUtil.debug('保存的脚本内容：${widget.gameScript.toJson()}');

    context.pop(widget.gameScript);
  }

  _buildTitle() {
    return const Row(
      children: [
        Text(
          'Header #0',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultLeftPadding),
      child: AppTextField(
        title: const TextNotNullWidget(text: '脚本名称'),
        hintText: "请输入名称",
        validator: InputValidator.notNull,
        autofocus: true,
        initialValue: widget.gameScript.name,
        onChanged: (val) => widget.gameScript.name = val,
      ),
    );
  }
}
