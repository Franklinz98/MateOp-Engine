import 'dart:io';
import 'dart:math';

import 'package:mateop_engine/engine/exercise_generator.dart';
import 'package:mateop_engine/engine/playground_controller.dart';
import 'package:mateop_engine/engine/score_controller.dart';
import 'package:mateop_engine/models/exercise.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';

class Playground {
  ExerciseManager exerciseManager;
  int hesitations = 0;
  int playerAnswer;
  Exercise currentExercise;
  MOUser user;

  void startSession() async {
    do {
      _showExercise();
      var ready = false;
      var playerAnswer = currentExercise.answer.toString();
      if (Random().nextDouble() > 0.75) {
        playerAnswer = '-1';
      } else {}
      /* var playerAnswer = double.infinity.toString();
      while (!ready) {
        playerAnswer = stdin.readLineSync();
        print('listo? Y/n');
        ready = stdin.readLineSync() == 'Y';
        hesitations++;
      } */
      await onReadyButtonPress(
          double.parse(playerAnswer),
          Duration(seconds: Random().nextInt(10) + 5),
          Random().nextInt(2),
          exerciseManager,
          user);
    } while (!exerciseManager.isTestFinished());
    updateFileWithVectorPerformace(exerciseManager, user);
  }

  void _showExercise() {
    currentExercise = exerciseManager.getCurrentExercise();
    print(
        '${currentExercise.firstOperator} + ${currentExercise.secondOperator} = ?');
    print(generateAnswerOptions(currentExercise.answer));
  }
}
