import 'dart:convert';

import 'exercise.dart';

class SessionFile {
  int index;
  List<Exercise> exercises;

  SessionFile(this.index, this.exercises);

  Map<String, dynamic> toJson() => {
        'index': index,
        'exercises': _encodeExercises(this.exercises),
      };

  factory SessionFile.fromJson(Map<String, dynamic> map) {
    List<Map> exercisesMap = json.decode(map['exercises']);
    var exercises = <Exercise>[];
    exercisesMap.forEach((exercise) {
      exercises.add(Exercise.fromJson(exercise));
    });
    return SessionFile(
      map['index'],
      exercises,
    );
  }

  String _encodeExercises(List<Exercise> exercises) {
    List<Map> exercisesMap = List();
    exercises.forEach((exercise) {
      exercisesMap.add(exercise.toJson());
    });
    return json.encode(exercisesMap);
  }
}
