import 'package:common_library/model/common_model.dart';
import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:transfer_arm/module/game_script/entity/game_script_flow.dart';

import '../constants/game_script_flow_type.dart';

class GameScriptFlowModel extends CommonModel<GameScriptFlow>{


  GameScriptFlowModel({super.data});

  set setType(GameScriptFlowType type) {
    data?.type = type.name;
    notifyListeners();
  }

  set setMouseEvent(MouseEvent mouseEvent) {
    data?.mouseEvent = mouseEvent.name;
    notifyListeners();
  }

}

