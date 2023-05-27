import 'package:go_router/go_router.dart';
import 'package:transfer_arm/module/game_script/entity/game_script.dart';
import 'package:transfer_arm/module/game_script/game_script_home_page.dart';

import '../module/game_script/widget/game_script_flow_page.dart';

// GoRouter configuration
final routers = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GameScriptHomePage(),
    ),
    GoRoute(
      path: GameScriptFlowPage.routerPath,
      name: GameScriptFlowPage.routerPath,
      builder: (context, state) => GameScriptFlowPage(
          gameScript: GameScript.fromJson(state.queryParameters)),
    ),
  ],
);
