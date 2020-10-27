import 'dart:math';

import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/models/exercise.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';

import 'exercise_generator.dart';

onReadyButtonPress(double playerAnswer, Duration duration, int hesitations,
    ExerciseManager exerciseManager, MOUser user) async {
  if (playerAnswer != double.infinity) {
    Exercise exercise = exerciseManager.getCurrentExercise();
    exercise.playerAnswer = playerAnswer;
    exercise.duration = duration;
    exerciseManager.finalTime += duration;
    exercise.hesitations = hesitations;
    if (exercise.playerAnswer != exercise.answer) {
      await writeOnFIleWrongExercise(exercise);
      exerciseManager.nextExercise();
    } else {
      exerciseManager.nextExercise();
    }
    writeSessionFile(exerciseManager, user);
  }
}
