import 'dart:convert';
import 'dart:io';

import 'exercise.dart';

class ExerciseManager {
  List<Exercise> allExercises;
  int currentExercise;
  Duration finalTime;

  ExerciseManager({this.allExercises, this.currentExercise, this.finalTime});

  void answerCurrentExercise(double ans) {
    getCurrentExercise().playerAnswer = ans;
  }

  void nextExercise() {
    if (currentExercise < allExercises.length) {
      currentExercise++;
    }
  }

  bool isTestFinished() {
    return currentExercise == allExercises.length;
  }

  Exercise getCurrentExercise() {
    return allExercises[currentExercise];
  }

  double getPorcentGoodAnswers() {
    double number, den;
    number = 0;
    den = allExercises.length as double;
    allExercises.forEach((exercise) {
      if (exercise.answer == exercise.playerAnswer) {
        number++;
      }
    });
    return (number / den);
  }

  int getGoodAnswers() {
    int number;
    number = 0;
    allExercises.forEach((exercise) {
      if (exercise.answer == exercise.playerAnswer) {
        number++;
      }
    });
    return number;
  }

  Map<String, dynamic> toJson() {
    List exercises = List();
    allExercises.forEach((exercise) {
      exercises.add(exercise.toJson());
    });
    return {
      'currentExercise': currentExercise,
      'finalTime': finalTime.inMilliseconds,
      'allExercises': json.encode(exercises),
    };
  }

  factory ExerciseManager.fromJson(Map<String, dynamic> map) {
    List exercisesJson = json.decode(map['allExercises']);
    List exercises = List();
    exercisesJson.forEach((exerciseJson) {
      exercises.add(Exercise.fromJson(exerciseJson));
    });
    return ExerciseManager(
      allExercises: map['allExercises'],
      currentExercise: map['currentExercise'],
      finalTime: map['finalTime'],
    );
  }
}
