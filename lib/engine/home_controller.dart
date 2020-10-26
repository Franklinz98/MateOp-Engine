import 'dart:io';
import 'dart:convert';

import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/backend/firebase_data.dart';
import 'package:mateop_engine/backend/service.dart';
import 'package:mateop_engine/engine/playground.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/intensities.dart';
import 'package:mateop_engine/models/performance_vectors.dart';
import 'package:mateop_engine/models/session_file.dart';
import 'package:mateop_engine/models/user.dart';

import 'exercise_generator.dart';

void start(Playground playground) async {
  ExerciseManager exerciseManager = playground.exerciseManager;
  MOUser user = playground.user;
  String path = localPath;
  File sessionFile = getLocalFile("$path/addition", "uid");
  if (sessionFile.existsSync()) {
    String fileContent = await sessionFile.readAsString();
    Map jsonObject = json.decode(fileContent);
    SessionFile session = SessionFile.fromJson(jsonObject);
    exerciseManager.currentExercise = session.index;
    exerciseManager.allExercises = session.exercises;
  } else {
    if (user.hasPerformanceData) {
      Map performanceData = await getPerformanceData(user);
      Intensity intensity = await getNextIntensityLevel(performanceData);
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      exerciseManager.allExercises = exercises;
      exerciseManager.currentExercise = 0;
      exerciseManager.finalTime = Duration();
      await playground.startSession();
    } else {
      Intensity intensity = await predictInicitalIntensity(user);
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      exerciseManager.allExercises = exercises;
      exerciseManager.currentExercise = 0;
      exerciseManager.finalTime = Duration();
      PerformanceVectors performanceVectors = PerformanceVectors();
      // performanceVectors.jsonIntensities =
      performanceVectors.grado = user.grade;
      performanceVectors.sesion = user.session;
      performanceVectors.tipoEscuela = user.schoolType;
      performanceVectors.setBinperPerformanceVectors([
        [1, 0],
        [1, 0],
        [1, 0],
        [1, 0],
        [1, 0]
      ]);
      performanceVectors.writeObjectInFile(localPath);
      await playground.startSession();
    }
  }
}
