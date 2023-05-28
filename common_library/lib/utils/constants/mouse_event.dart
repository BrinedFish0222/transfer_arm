enum MouseEvent {
  leftClick(value: 0, desc: '左键点击'),
  middleClick(value: 1, desc: '中间点击'),
  rightClick(value: 2, desc: '右键点击'),
  ;

  const MouseEvent({required this.value, required this.desc});

  final int value;
  final String desc;

}