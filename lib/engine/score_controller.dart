import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/backend/firebase_data.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/performance_vectors.dart';
import 'package:mateop_engine/models/user.dart';

void updateFileWithVectorPerformace(
    ExerciseManager exerciseManager, MOUser user) {
  PerformanceVectors performanceVectors =
      PerformanceVectors.readObjectFromFile(localPath);
  performanceVectors.updatePerformanceVectorsSet(
      exerciseManager.allExercises, user.grade, user.session);
  performanceVectors.writeObjectInFile(localPath);
  try {
    updatePerformanceData(user, performanceVectors.toJson);
    // clearSessionFile(user);
    deleteSessionFile(user);
    // updateAverageTimes(exerciseManager, user);
  } catch (e) {
    print(e.toString());
  }
}

void updateAverageTimes(ExerciseManager exerciseManager, MOUser user) async {
  Map times = await getAverageTimes(user.schoolType);
  String grade = user.grade.toString();
  for (var i = 0; i < 5; i++) {
    int number = times['metadata'][i][grade];
    double time = times['data'][i][grade].toDouble();
    double uTime = exerciseManager.getAverageTimePerLO(i);
    if (!uTime.isNaN) {
      time = (time * (number / (number + 1))) + (uTime / (number + 1));
      times['metadata'][i][grade] = number + 1;
      times['data'][i][grade] = time;
    }
  }
  await setAverageTimes(times, user.schoolType);
}
