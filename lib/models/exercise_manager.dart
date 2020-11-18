import 'dart:convert';
import 'dart:io';

import 'exercise.dart';

class ExerciseManager {
  List allExercises;
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
    double den = allExercises.length.toDouble();
    den = (getGoodAnswers() / den);
    return (den * 100).roundToDouble() / 100;
  }

  int getStarsCount() {
    int stars = getGoodAnswers() ~/ 5;
    return stars;
  }

  int getGoodAnswers() {
    int number;
    number = 0;
    allExercises.forEach((exercise) {
      if (exercise.checkAnswer()) {
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
      allExercises: exercises,
      currentExercise: map['currentExercise'],
      finalTime: Duration(milliseconds: map['finalTime']),
    );
  }
  int getSessionScore() {
    double score = 0;
    allExercises.forEach((exercise) {
      score += exerciseScore(exercise);
    });
    score *= 150;
    return score.round();
  }

  double exerciseScore(Exercise exercise) {
    if (exercise.checkAnswer()) {
      double time = (1 / exercise.duration.inSeconds) * 0.4;
      double hesitation = (1 / (exercise.hesitations + 1)) * 0.6;
      return time + hesitation;
    } else {
      return 0;
    }
  }

  double getAverageTimePerLO(int lo) {
    double av = 0;
    int cont = 0;
    allExercises.forEach((exercise) {
      if (exercise.loID == lo) {
        av += exercise.duration.inSeconds.toDouble();
        cont++;
      }
    });
    return av / cont;
  }
}
