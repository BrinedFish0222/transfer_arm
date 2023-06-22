import 'package:common_library/utils/string_util.dart';

enum GameScriptFlowType {
  mouse(description: '鼠标'),
  wait(description: '等待'),
  ;

  final String description;

  const GameScriptFlowType({required this.description});

  static GameScriptFlowType getByName(String? name) {
    if (StringUtil.isBlank(name)) {
      return GameScriptFlowType.mouse;
    }

    return GameScriptFlowType.values.firstWhere((e) => e.name == name,
        orElse: () => GameScriptFlowType.mouse);
  }
}
