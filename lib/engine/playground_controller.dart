import 'dart:math';

import 'package:mateop_engine/models/exercise.dart';
import 'package:mateop_engine/models/exercise_manager.dart';

import 'exercise_generator.dart';

onReadyButtonPress(double playerAnswer, Duration duration, int hesitations,
    ExerciseManager exerciseManager) {
  if (playerAnswer != double.infinity) {
    Exercise exercise = exerciseManager.getCurrentExercise();
    exercise.playerAnswer = playerAnswer;
    exercise.duration = duration;
    exerciseManager.finalTime += duration;
    exercise.hesitations = hesitations;
    if (exercise.playerAnswer != exercise.answer) {
      writeOnFIleWrongExercise(exercise);
    } else {
      exerciseManager.nextExercise();
    }
  }
}
