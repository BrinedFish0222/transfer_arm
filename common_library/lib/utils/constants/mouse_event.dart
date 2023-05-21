enum MouseEvent {
  leftClick(value: 0),
  middleClick(value: 1),
  rightClick(value: 2),
  ;

  const MouseEvent({required this.value});

  final int value;

}