import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfer_arm/pages/game_scirpt/widget/game_script_list_widget.dart';

import 'model/game_script_model.dart';

class GameScriptHomePage extends StatelessWidget {
  const GameScriptHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameScriptModel(),
      child: const Scaffold(
        body: GameScriptListWidget(),
      ),
    );
  }
}


