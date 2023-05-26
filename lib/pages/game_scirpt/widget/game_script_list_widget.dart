import 'package:common_library/utils/log_util.dart';
import 'package:common_library/widget/app_icons.dart';
import 'package:common_library/widget/common_widget.dart';
import 'package:common_library/widget/common_widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../entity/game_script.dart';
import '../model/game_script_model.dart';

/// 脚本列表
class GameScriptListWidget extends StatefulWidget {
  const GameScriptListWidget({Key? key}) : super(key: key);

  @override
  State<GameScriptListWidget> createState() => _GameScriptListWidgetState();
}

class _GameScriptListWidgetState extends State<GameScriptListWidget> with CommonWidget {

  late GameScriptModel _gameScriptModel;

  @override
  Widget build(BuildContext context) {
    _gameScriptModel = context.watch<GameScriptModel>();
    return Padding(
      padding: EdgeInsets.all(leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: _createEvent, child: const Text("新建")),
          SizedBox(height: lineHeight,),
          Expanded(child: ListView(children: _gameScriptModel.dataList.map((e) => Row(
            children: [
              SizedBox(width: 10.w,),
              Expanded(flex: 6,child: Text(e.name)),
              Expanded(flex: 2,child: IconButton(onPressed: (){}, icon: const Icon(AppIcons.start))),
              Expanded(flex: 2,child: IconButton(onPressed: (){}, icon: const Icon(AppIcons.edit))),
              Expanded(flex: 2,child: IconButton(onPressed: (){}, icon: const Icon(AppIcons.delete))),
            ],
          )).toList(),)),
        ],
      ),
    );
  }

  _createEvent() async {
    LogUtil.debug('_createEvent 执行');
    String? name =
        await CommonWidgetUtils.buildInputDialog(context: context, title: '新建');
    if (name == null) {
      return null;
    }

    _gameScriptModel.dataList.add(GameScript(name: name));
    _gameScriptModel.notifyListeners();
  }
}
