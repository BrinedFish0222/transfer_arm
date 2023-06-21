import 'package:common_library/constants/input_formats.dart';
import 'package:common_library/utils/common_widget_util.dart';
import 'package:common_library/utils/confirm_dialog_utils.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:common_library/widget/app_icons.dart';
import 'package:common_library/widget/app_text_field.dart';
import 'package:common_library/widget/text_not_null_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/model/game_script_model.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_edit_widget.dart';

import '../../../themes/app_theme.dart';

/// 脚本流程页/脚本编辑
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

class _GameScriptFlowPageState extends State<GameScriptFlowPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  late GameScriptModel _model;

  @override
  void initState() {
    _model = GameScriptModel(data: widget.gameScript)..loadScript();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameScriptModel>.value(
      value: _model,
      child: Consumer<GameScriptModel>(builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => _backEvent(model),
            ),
            title: const Text("脚本流程"),
            actions: [
              TextButton(
                  onPressed: () => _saveEvent(model),
                  child: Text(
                    '保存',
                    style: TextStyle(color: AppTheme.appBarBtnColor),
                  ))
            ],
          ),
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    child: const Text(
                      '流程',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  sliver: SliverReorderableList(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildFlowContent(model.data!.flowList![index]);
                    },
                    itemCount: model.data?.flowList?.length ?? 0,
                    onReorder: (int oldIndex, int newIndex) {},
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _buildAddScriptFlow(model),
              child: const Icon(Icons.add)),
        );
      }),
    );
  }

  /// 新增脚本流程
  _buildAddScriptFlow(GameScriptModel model) async {
    GameScriptFlow? gameScriptFlow =
        await CommonWidgetUtil.buildBottomSheet<GameScriptFlow>(
            context: context,
            isDismissible: false,
            heightRadio: 0.7,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: GameScriptFlowEditWidget(),
            ));

    if (gameScriptFlow == null) {
      return;
    }

    model.data?.flowList ??= [];
    model.data?.flowList?.add(gameScriptFlow);
    model.notifyListeners();
  }

  _backEvent(GameScriptModel model) async {
    bool isBack = await ConfirmDialogUtils.isSaveDialog(context);
    if (!mounted) return;
    LogUtil.debug('isBack: $isBack');
    if (isBack) {
      _saveEvent(model);
      return;
    }
    context.pop();
  }

  _saveEvent(GameScriptModel model) {
    LogUtil.debug('保存的脚本内容：${widget.gameScript.toJson()}');
    model.save();

    context.pop(widget.gameScript);
  }

  _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: AppTextField(
        title: const TextNotNullWidget('脚本名称'),
        hintText: "请输入名称",
        validator: InputValidator.notNull,
        autofocus: true,
        initialValue: widget.gameScript.name,
        onChanged: (val) => widget.gameScript.name = val,
      ),
    );
  }

  /// 构建：流程展示内容
  Widget _buildFlowContent(GameScriptFlow flow) {
    double width = 20.w;
    Widget showWidget = GsFlowMouseWidget(flow: flow, width: width);
    if (flow.type == GameScriptFlowType.wait) {
      showWidget = GsFlowWaitWidget(flow: flow, width: width);
    }

    return Padding(
        key: ValueKey(flow),
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Expanded(child: showWidget),
            IconButton(onPressed: () async {
              bool isDel = await ConfirmDialogUtils.isDeleteDialog(context);
              if (!isDel) {
                  return;
              }
              _model.deleteFlow(flow);
            }, icon: const Icon(AppIcons.delete))
          ],
        ));
  }
}

/// 脚本内容展示 - 等待时间
class GsFlowWaitWidget extends StatelessWidget {
  const GsFlowWaitWidget({Key? key, this.width, required this.flow})
      : super(key: key);

  final double? width;
  final GameScriptFlow flow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(flow.type.desc),
        if (width != null)
          SizedBox(
            width: width,
          ),
        Text("时长（毫秒值）：${flow.waitMillisecond?.toString() ?? ''}"),
        if (width != null)
          SizedBox(
            width: width,
          ),
        Text("浮动数：${flow.axisFloat?.toString() ?? ''}"),
      ],
    );
  }
}

/// 脚本内容展示 - 鼠标
class GsFlowMouseWidget extends StatelessWidget {
  const GsFlowMouseWidget({Key? key, this.width, required this.flow})
      : super(key: key);

  final double? width;
  final GameScriptFlow flow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(flow.mouseEvent?.desc ?? ''),
        if (width != null)
          SizedBox(
            width: width,
          ),
        Text("x轴：${flow.axisX?.toString() ?? ''}"),
        if (width != null)
          SizedBox(
            width: width,
          ),
        Text("y轴：${flow.axisY?.toString() ?? ''}"),
        if (width != null)
          SizedBox(
            width: width,
          ),
        Text("浮动数：${flow.axisFloat?.toString() ?? ''}"),
      ],
    );
  }
}
