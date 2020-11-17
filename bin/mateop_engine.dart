import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/engine/home_controller.dart';
import 'package:mateop_engine/engine/playground.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';

void main(List<String> arguments) async {
  MOUser user = MOUser(6, 1, 1, 1, false);
  user.uid = '0TetecMKONY8Tepr2wvYHayYnBw1';
  Playground playground = Playground();
  playground.user = user;
  user.session = 0;
  for (var i = 0; i < 100; i++) {
    user.hasPerformanceData = i != 0;
    await start(playground);
  }
}
