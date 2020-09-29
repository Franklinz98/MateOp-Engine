import 'exercise.dart';

class SavedExercise {
  final String intensity;
  final int dificulty;
  final Exercise exercise;

  const SavedExercise(this.intensity, this.dificulty, this.exercise);

  Map<String, dynamic> toJson() => {
        'intensity': intensity,
        'dificulty': dificulty,
        'exercise': exercise.toJson(),
      };

  factory SavedExercise.fromJson(Map<String, dynamic> json) {
    return SavedExercise(json['intensity'], json['dificulty'],
        Exercise.fromJson(json['exercise']));
  }
}
