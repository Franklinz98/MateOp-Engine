import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/engine/home_controller.dart';
import 'package:mateop_engine/engine/playground.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';

void main(List<String> arguments) async {
  setTimes();
  MOUser user = MOUser(6, 1, 1, 1, false);
  user.uid = '0TetecMKONY8Tepr2wvYHayYnBw1';
  Playground playground = Playground();
  playground.user = user;
  playground.exerciseManager = ExerciseManager();
  for (var i = 0; i < 100; i++) {
    user.session = i;
    user.hasPerformanceData = i != 0;
    await start(playground);
    print(
        'done $i - WinRate: ${playground.exerciseManager.getPorcentGoodAnswers()} - Stars: ${playground.exerciseManager.getStarsCount()} - Score: ${playground.exerciseManager.getSessionScore()}');
  }
}
