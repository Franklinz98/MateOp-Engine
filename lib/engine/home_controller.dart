import 'dart:io';
import 'dart:convert';

import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/backend/firebase_data.dart';
import 'package:mateop_engine/backend/service.dart';
import 'package:mateop_engine/engine/playground.dart';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/intensities.dart';
import 'package:mateop_engine/models/performance_vectors.dart';
import 'package:mateop_engine/models/user.dart';

import 'exercise_generator.dart';

void start(Playground playground) async {
  MOUser user = playground.user;
  /* bool sessionExist = checkSessionFile(user);
  if (sessionExist) { */
  if (getLocalFile(localPath, 'session_file_${user.uid}').existsSync()) {
    playground.exerciseManager = readSessionFile(user);
    await playground.startSession();
  } else {
    if (user.hasPerformanceData) {
      Map performanceData = getPerformanceData(user);
      Intensity intensity = await getNextIntensityLevel(performanceData);
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      playground.exerciseManager = ExerciseManager();
      playground.exerciseManager.allExercises = exercises;
      playground.exerciseManager.currentExercise = 0;
      playground.exerciseManager.finalTime = Duration();
      await playground.startSession();
    } else {
      Intensity intensity = await predictInicitalIntensity(user);
      print('predicted');
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      playground.exerciseManager = ExerciseManager();
      playground.exerciseManager.allExercises = exercises;
      playground.exerciseManager.currentExercise = 0;
      playground.exerciseManager.finalTime = Duration();
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
