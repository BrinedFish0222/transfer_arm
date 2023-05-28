import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:common_library/widget/app_dropdown_btn.dart';
import 'package:common_library/widget/app_text_field.dart';
import 'package:common_library/widget/left_right_widget.dart';
import 'package:common_library/widget/single_line_fitted_box.dart';
import 'package:common_library/widget/text_not_null_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';
import 'package:transfer_arm/module/game_script/model/game_script_flow_model.dart';

import '../constants/game_script_flow_type.dart';

/// 脚本编辑
class GameScriptFlowEditWidget extends StatelessWidget {
  const GameScriptFlowEditWidget({Key? key, this.gameScriptFlow}) : super(key: key);

  final GameScriptFlow? gameScriptFlow;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameScriptFlowModel(data: gameScriptFlow ?? GameScriptFlow()),
      child: Consumer<GameScriptFlowModel>(builder: (context, model, _) {
        return ListView(
          children: [
            LeftRightWidget(leftChild: const SingleLineFittedBox(child: Text('类型')), rightChild: AppDropdownBtn<GameScriptFlowType>(
              value: model.data?.type ?? GameScriptFlowType.mouse,
              onChanged: (value) => model.setType = value!,
              items: GameScriptFlowType.values
                  .map((e) => DropdownMenuItem<GameScriptFlowType>(
                value: e,
                child: Text(e.desc),
              ))
                  .toList(),
            )),
            if (model.data?.type == GameScriptFlowType.mouse)
              const GsFlowEditMouse(),
            if (model.data?.type == GameScriptFlowType.wait)
              const GsFlowEditWait(),

            SizedBox(height: 10.h * 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () => context.pop(), child: const Text("取消")),
                ElevatedButton(onPressed: () => context.pop(model.data), child: const Text("确认")),
              ],)
          ],
        );
      }),
    );
  }
}

/// 脚本流程等待类型表单
class GsFlowEditWait extends StatelessWidget {
  const GsFlowEditWait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double interval = 10.w;

    return Consumer<GameScriptFlowModel>(
        builder: (context, model, _) {
          return Column(children: [
            AppTextField(
              title: const TextNotNullWidget('等待时间（毫秒值）'),
              interval: interval,
              hintText: '请输入等待时间',
              onChanged: (val) => model.data?.waitMillisecond = int.parse(val),
            ),

            AppTextField(
              title: const Text('浮动数'),
              hintText: '请输入浮动数',
              interval: interval,
              onChanged: (val) => model.data?.axisFloat = int.parse(val),
            ),
          ],);
        }
    );
  }
}


/// 脚本流程鼠标类型表单
class GsFlowEditMouse extends StatelessWidget {
  const GsFlowEditMouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameScriptFlowModel>(
      builder: (context, model, _) {
        return Column(children: [
          LeftRightWidget(leftChild: const SingleLineFittedBox(child: Text('鼠标操作类型')), rightChild: AppDropdownBtn<MouseEvent>(
            value: model.data?.mouseEvent ?? MouseEvent.leftClick,
            onChanged: (value) => model.setMouseEvent = value!,
            items: MouseEvent.values
                .map((e) => DropdownMenuItem<MouseEvent>(
              value: e,
              child: Text(e.desc),
            ))
                .toList(),
          )),
          AppTextField(
            title: const TextNotNullWidget('x轴'),
            hintText: '请输入x轴',
            onChanged: (val) => model.data?.axisX = int.parse(val),
          ),
          AppTextField(
            title: const TextNotNullWidget('y轴'),
            hintText: '请输入y轴',
            onChanged: (val) => model.data?.axisY = int.parse(val),
          ),
          AppTextField(
            title: const Text('浮动数'),
            hintText: '请输入浮动数',
            onChanged: (val) => model.data?.axisFloat = int.parse(val),
          ),
        ],);
      }
    );
  }
}


