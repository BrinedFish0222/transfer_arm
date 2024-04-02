import 'package:common_library/constants/input_formats.dart';
import 'package:common_library/utils/common_widget_util.dart';
import 'package:common_library/utils/confirm_dialog_utils.dart';
import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:common_library/utils/string_util.dart';
import 'package:common_library/widget/app_icons.dart';
import 'package:common_library/widget/app_text_field.dart';
import 'package:common_library/widget/text_not_null_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/constants/game_script_flow_type.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/model/game_script_model.dart';
import 'package:transfer_arm/module/game_script/widget/game_script_flow_edit_widget.dart';

import '../../../themes/app_theme.dart';

/// 脚本流程页/脚本编辑
class GameScriptFlowPage extends StatefulWidget {
  const GameScriptFlowPage({
    Key? key,
  }) : super(key: key);

  static const String routerPath = "/gameScript/flowPage";

  @override
  State<GameScriptFlowPage> createState() => _GameScriptFlowPageState();
}

class _GameScriptFlowPageState extends State<GameScriptFlowPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    GameScriptListModel model = context.watch<GameScriptListModel>();

    int flowLength = model.editGameScript?.flowList?.length ?? 0;

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
              child: _buildName(context, model),
            ),
            SliverToBoxAdapter(
              child: _buildRunNum(context, model),
            ),
            SliverToBoxAdapter(
              child: _buildDescription(context, model),
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
                  if (index == flowLength) {
                    return Container(height: 100, key: UniqueKey(),);
                  }
                  return _buildFlowContent(
                      model, model.editGameScript!.flowList![index]);
                },
                itemCount: flowLength + 1,
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
  }

  /// 新增脚本流程
  _buildAddScriptFlow(GameScriptListModel model) async {
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

    model.editGameScript?.flowList ??= [];
    model.editGameScript?.flowList!.add(gameScriptFlow);
    model.notifyListeners();
  }

  _backEvent(GameScriptListModel model) async {
    bool isBack = await ConfirmDialogUtils.isSaveDialog(context);
    if (!mounted) return;
    LogUtil.debug('isBack: $isBack');
    if (isBack) {
      _saveEvent(model);
      return;
    }
    context.pop();
  }

  _saveEvent(GameScriptListModel model) {
    LogUtil.debug('保存的脚本内容：${model.editGameScript?.toJson()}');
    model.saveEditGameScript();
    context.pop();
  }

  _buildName(BuildContext context, GameScriptListModel model) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: AppTextField(
        title: const TextNotNullWidget('脚本名称'),
        hintText: "请输入名称",
        validator: InputValidator.notNull,
        autofocus: true,
        initialValue: model.editGameScript?.name,
        onChanged: (val) => model.editGameScript?.name = val,
      ),
    );
  }

  /// 构建执行次数
  _buildRunNum(BuildContext context, GameScriptListModel model) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: AppTextField(
        title: const Text('执行次数'),
        hintText: "请输入执行次数",
        // validator: InputValidator.notNull,
        initialValue: StringUtil.parseInt(model.editGameScript?.runNum),
        onChanged: (val) =>
            model.editGameScript?.runNum = StringUtil.toInt(val),
      ),
    );
  }

  _buildDescription(BuildContext context, GameScriptListModel model) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: AppTextField(
        title: const Text('描述'),
        hintText: "请输入描述",
        // validator: InputValidator.notNull,
        initialValue: model.editGameScript?.description,
        onChanged: (val) => model.editGameScript?.description = val,
      ),
    );
  }

  /// 构建：流程展示内容
  Widget _buildFlowContent(GameScriptListModel model, GameScriptFlow flow) {
    double width = 20.w;
    Widget showWidget = GsFlowMouseWidget(flow: flow, width: width);
    if (flow.type == GameScriptFlowType.wait.name) {
      showWidget = GsFlowWaitWidget(flow: flow, width: width);
    }

    return Padding(
        key: ValueKey(flow),
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Expanded(child: showWidget),
            IconButton(
                onPressed: () async {
                  bool isDel = await ConfirmDialogUtils.isDeleteDialog(context);
                  if (!isDel) {
                    return;
                  }
                  model.deleteEditGameScriptFlow(flow);
                },
                icon: const Icon(AppIcons.delete))
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
        Text(GameScriptFlowType.getByName(flow.type).description),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(GameScriptFlowType.getByName(flow.type).description),
          if (flow.mouseEvent != null)
            Text('：${MouseEvent.getByName(flow.mouseEvent).description}'),
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
      ),
    );
  }
}
