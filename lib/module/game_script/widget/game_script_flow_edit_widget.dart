import 'package:common_library/widget/app_text_field.dart';
import 'package:flutter/material.dart';

/// 脚本编辑
class GameScriptFlowEditWidget extends StatefulWidget {
  const GameScriptFlowEditWidget({Key? key}) : super(key: key);

  @override
  State<GameScriptFlowEditWidget> createState() => _GameScriptFlowEditWidgetState();
}

class _GameScriptFlowEditWidgetState extends State<GameScriptFlowEditWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      AppTextField(title: Text('x轴：')),
      AppTextField(title: Text('y轴：'))
    ],);
  }
}
