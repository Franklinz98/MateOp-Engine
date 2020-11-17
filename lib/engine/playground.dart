import 'dart:io';
import 'dart:math';

import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/engine/exercise_generator.dart';
import 'package:mateop_engine/engine/playground_controller.dart';
import 'package:mateop_engine/engine/score_controller.dart';
import 'package:mateop_engine/models/exercise.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';
import 'package:mateop_engine/simulation/curves.dart';

class Playground {
  ExerciseManager exerciseManager;
  int hesitations = 0;
  int playerAnswer;
  Exercise currentExercise;
  MOUser user;

  void startSession() async {
    int correctAnswers = Curves.gaus(user.session);
    int correctCount = 0;
    do {
      _showExercise();
      await writeSessionFile(exerciseManager, user);
      var playerAnswer = '-1';
      if (correctCount < correctAnswers) {
        playerAnswer = currentExercise.answer.toString();
        correctCount++;
      }
      /* var playerAnswer = double.infinity.toString();
      while (!ready) {
        playerAnswer = stdin.readLineSync();
        print('listo? Y/n');
        ready = stdin.readLineSync() == 'Y';
        hesitations++;
      } */
      print(exerciseManager.currentExercise);/*
      if (Random().nextDouble() > 0.98) {
        print('cut session');
        break;
      } */
      await onReadyButtonPress(
          double.parse(playerAnswer),
          Duration(seconds: Random().nextInt(10) + 5),
          Random().nextInt(2),
          exerciseManager,
          user);
      if (exerciseManager.isTestFinished()) {
        user.session++;
        updateFileWithVectorPerformace(exerciseManager, user);
        print(
            'done ${user.session} - WinRate: ${exerciseManager.getPorcentGoodAnswers()} - Stars: ${exerciseManager.getStarsCount()} - Score: ${exerciseManager.getSessionScore()}');
      }
    } while (!exerciseManager.isTestFinished());
  }

  void _showExercise() {
    currentExercise = exerciseManager.getCurrentExercise();
    print(
        '${currentExercise.firstOperator} + ${currentExercise.secondOperator} = ?');
    print(generateAnswerOptions(currentExercise.answer));
  }
}
