import 'exercise.dart';

class ExerciseManager {
  List<Exercise> allExercises;
  int currentExercise;
  Duration finalTime;

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
}
