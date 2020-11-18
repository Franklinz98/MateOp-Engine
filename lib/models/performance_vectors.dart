import 'dart:convert';
import 'dart:io';

import 'package:mateop_engine/backend/data.dart';

import 'exercise.dart';

class PerformanceVectors {
  List learningObjectives;
  int grado;
  int sesion;
  int tipoEscuela;
  List tiempos;
  List correcto;
  List dificultad;
  List titubeo;
  List binLO0;
  List binLO1;
  List binLO2;
  List binLO3;
  List binLO4;
  List binPer;
  List mulLO0;
  List mulLO1;
  List mulLO2;
  List mulLO3;
  List mulLO4;
  List mulPer;
  Map jsonIntensities;
  int numLO;
  PerformanceVectors() {
    learningObjectives = List();
    tiempos = List();
    correcto = List();
    dificultad = List();
    titubeo = List();
    binLO0 = List();
    binLO1 = List();
    binLO2 = List();
    binLO3 = List();
    binLO4 = List();
    binPer = List();
    mulLO0 = List();
    mulLO1 = List();
    mulLO2 = List();
    mulLO3 = List();
    mulLO4 = List();
    mulPer = List();
    for (var i = 0; i < 5; i++) {
      binPer.add(List());
      mulPer.add(List());
    }
    jsonIntensities = {};
  }

  void updatePerformanceVectorsSet(List exercises, int grado, int sesion) {
    learningObjectives = List(exercises.length);
    tiempos = List(exercises.length);
    correcto = List(exercises.length);
    dificultad = List(exercises.length);
    titubeo = List(exercises.length);
    this.grado = grado;
    this.sesion = sesion;
    var i = 0;
    exercises.forEach((exercise) {
      if (exercise.duration == null) {
        print(null);
      }
      learningObjectives[i] = exercise.loID;
      tiempos[i] = exercise.duration.inSeconds;
      dificultad[i] = exercise.dificulty;
      titubeo[i] = exercise.hesitations;

      if (exercise.answer == exercise.playerAnswer) {
        correcto[i] = 1;
      } else {
        correcto[i] = 0;
      }
      i++;
    });
  }

  void setBinLoPerformanceVectors(
      List binLO0, List binLO1, List binLO2, List binLO3, List binLO4) {
    this.binLO0 = binLO0;
    this.binLO1 = binLO1;
    this.binLO2 = binLO2;
    this.binLO3 = binLO3;
    this.binLO4 = binLO4;
  }

  void setBinperPerformanceVectors(List binPer) {
    this.binPer = binPer;
  }

  void setMulLoformanceVectors(
      List mulLO0, List mulLO1, List mulLO2, List mulLO3, List mulLO4) {
    this.mulLO0 = mulLO0;
    this.mulLO1 = mulLO1;
    this.mulLO2 = mulLO2;
    this.mulLO3 = mulLO3;
    this.mulLO4 = mulLO4;
  }

  void setMulPerPerformanceVectors(List mulPer) {
    this.mulPer = mulPer;
  }

  void setIntensities(Map intensities) {
    this.jsonIntensities = intensities;
  }

  Map get toJson {
    return {
      'LO': learningObjectives,
      'grado': grado,
      'sesion': sesion,
      'tipoEscuela': tipoEscuela,
      'tiempos': tiempos,
      'correcto': correcto,
      'titubeo': titubeo,
      'dificultad': dificultad,
      'binLO0': binLO0,
      'binLO1': binLO1,
      'binLO2': binLO2,
      'binLO3': binLO3,
      'binLO4': binLO4,
      'binPer': binPer,
      'mulLO0': mulLO0,
      'mulLO1': mulLO1,
      'mulLO2': mulLO2,
      'mulLO3': mulLO3,
      'mulLO4': mulLO4,
      'mulPer': mulPer,
      'Intensities': jsonIntensities,
      'numLO': 5,
    };
  }

  void writeObjectInFile(String path) {
    File('$path/PerformanceVectors.json')
        .writeAsStringSync(json.encode(toJson));
  }

  factory PerformanceVectors.fromJson(Map performanceVectorMap) {
    PerformanceVectors myPerformanceVector = PerformanceVectors();
    myPerformanceVector.learningObjectives =
        List.of(performanceVectorMap['LO']);
    myPerformanceVector.grado = performanceVectorMap['grado'];
    myPerformanceVector.sesion = performanceVectorMap['sesion'];
    myPerformanceVector.tipoEscuela = performanceVectorMap['tipoEscuela'];
    myPerformanceVector.tiempos = List.of(performanceVectorMap['tiempos']);
    myPerformanceVector.correcto = List.of(performanceVectorMap['correcto']);
    myPerformanceVector.titubeo = List.of(performanceVectorMap['titubeo']);
    myPerformanceVector.dificultad =
        List.of(performanceVectorMap['dificultad']);
    myPerformanceVector.binLO0 = performanceVectorMap['binLO0'];
    myPerformanceVector.binLO1 = performanceVectorMap['binLO1'];
    myPerformanceVector.binLO2 = performanceVectorMap['binLO2'];
    myPerformanceVector.binLO3 = performanceVectorMap['binLO3'];
    myPerformanceVector.binLO4 = performanceVectorMap['binLO4'];
    myPerformanceVector.binPer = performanceVectorMap['binPer'];
    myPerformanceVector.mulLO0 = performanceVectorMap['mulLO0'];
    myPerformanceVector.mulLO1 = performanceVectorMap['mulLO1'];
    myPerformanceVector.mulLO2 = performanceVectorMap['mulLO2'];
    myPerformanceVector.mulLO3 = performanceVectorMap['mulLO3'];
    myPerformanceVector.mulLO4 = performanceVectorMap['mulLO4'];
    myPerformanceVector.mulPer = performanceVectorMap['mulPer'];
    myPerformanceVector.jsonIntensities = performanceVectorMap['Intensities'];
    myPerformanceVector.numLO = performanceVectorMap['numLO'];
    return myPerformanceVector;
  }

  factory PerformanceVectors.readObjectFromFile(String path) {
    var file = File('$path/PerformanceVectors.json');
    if (file.existsSync()) {
      return PerformanceVectors.fromJson(
        json.decode(
          file.readAsStringSync(),
        ),
      );
    } else {
      return null;
    }
  }

  static void writeJsonInFile(Map map) {
    File('$localPath/PerformanceVectors.json')
        .writeAsStringSync(json.encode(map));
  }

  dynamic getIntensitiesOfJson(Map performanceVectorsMap) {
    return performanceVectorsMap['Intensities'];
  }
}
