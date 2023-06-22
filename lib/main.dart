import 'package:common_library/utils/database_helper.dart';
import 'package:common_library/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'config/router_config.dart';
import 'module/game_script/model/game_script_model.dart';
import 'module/game_script/model/game_script_run_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.storage.request();

  await DatabaseHelper.create();
  await ScreenUtil.ensureScreenSize();



  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    LogUtil.debug('应用程序 initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    LogUtil.debug('应用程序 dispose');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // 应用程序进入后台时执行的操作
      // 在此处添加你的代码
    } else if (state == AppLifecycleState.resumed) {
      // 应用程序从后台返回前台时执行的操作
      // 在此处添加你的代码
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameScriptListModel>(create: (_) => GameScriptListModel()..loadScriptList()),
        ChangeNotifierProvider<GameScriptRunModel>(create: (_) => GameScriptRunModel()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routers,
            );
          }),
    );
  }
}
