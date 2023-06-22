import 'package:common_library/utils/string_util.dart';

enum MouseEvent {
  leftClick(value: 0, description: '左键点击'),
  middleClick(value: 1, description: '中间点击'),
  rightClick(value: 2, description: '右键点击'),
  ;

  const MouseEvent({required this.value, required this.description});

  final int value;
  final String description;

  static MouseEvent getByName(String? name) {
    if (StringUtil.isBlank(name)) {
      return MouseEvent.leftClick;
    }

    return MouseEvent.values
        .firstWhere((e) => e.name == name, orElse: () => MouseEvent.leftClick);
  }
}
