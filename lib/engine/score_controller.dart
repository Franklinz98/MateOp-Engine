import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/backend/firebase_data.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/performance_vectors.dart';
import 'package:mateop_engine/models/user.dart';

void updateFileWithVectorPerformace(
    ExerciseManager exerciseManager, MOUser user) async {
  PerformanceVectors performanceVectors =
      PerformanceVectors.readObjectFromFile(localPath);
  performanceVectors.updatePerformanceVectorsSet(
      exerciseManager.allExercises, user.grade, user.session);
  performanceVectors.writeObjectInFile(localPath);
  await updatePerformanceData(user, performanceVectors.toJson);
}
