enum GameScriptFlowType {
  mouse(desc: '鼠标'),
  // keyboard,
  wait(desc: '等待'),
  ;

  final String desc;

  const GameScriptFlowType({required this.desc});

}
