import 'dart:convert';
import 'dart:io';

import 'package:mateop_engine/backend/data.dart';

import 'exercise.dart';

class PerformanceVectors {
  List<int> learningObjectives;
  int grado;
  int sesion;
  int tipoEscuela;
  List<int> tiempos;
  List<int> correcto;
  List<int> dificultad;
  List<int> titubeo;

  List<List<int>> binLO0;
  List<List<int>> binLO1;
  List<List<int>> binLO2;
  List<List<int>> binLO3;
  List<List<int>> binLO4;
  List<List<int>> binPer;
  List<List<int>> mulLO0;
  List<List<int>> mulLO1;
  List<List<int>> mulLO2;
  List<List<int>> mulLO3;
  List<List<int>> mulLO4;
  List<List<int>> mulPer;
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

  void updatePerformanceVectorsSet(
      List<Exercise> exercises, int grado, int sesion) {
    learningObjectives = List(exercises.length);
    tiempos = List(exercises.length);
    correcto = List(exercises.length);
    dificultad = List(exercises.length);
    titubeo = List(exercises.length);
    this.grado = grado;
    this.sesion = sesion;
    int i = 0;
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

  List<List<int>> getJsonfromMatrix(List<List<int>> matrix) {
    /* var string = json.encode(matrix);
    return string; */
    return matrix;
  }

  static List<List<int>> getMatrixfromJson(List jsonRead) {
    // List tempList = json.decode(jsonRead);
    List<List<int>> list = List();
    jsonRead.forEach((element) {
      list.add(element.cast<int>());
    });
    return list;
  }

  setBinloPerformanceVectors(List<List<int>> binLO0, List<List<int>> binLO1,
      List<List<int>> binLO2, List<List<int>> binLO3, List<List<int>> binLO4) {
    this.binLO0 = binLO0;
    this.binLO1 = binLO1;
    this.binLO2 = binLO2;
    this.binLO3 = binLO3;
    this.binLO4 = binLO4;
  }

  setBinperPerformanceVectors(List<int> binLO0, List<int> binLO1,
      List<int> binLO2, List<int> binLO3, List<int> binLO4) {
    this.binPer[0] = binLO0;
    this.binPer[1] = binLO1;
    this.binPer[2] = binLO2;
    this.binPer[3] = binLO3;
    this.binPer[4] = binLO4;
  }

  setMulPerformanceVectors(List<List<int>> mulLO0, List<List<int>> mulLO1,
      List<List<int>> mulLO2, List<List<int>> mulLO3, List<List<int>> mulLO4) {
    this.mulLO0 = mulLO0;
    this.mulLO1 = mulLO1;
    this.mulLO2 = mulLO2;
    this.mulLO3 = mulLO3;
    this.mulLO4 = mulLO4;
  }

  Map toJson() {
    return {
      'LO': learningObjectives,
      'grado': grado,
      'sesion': sesion,
      'tipoEscuela': tipoEscuela,
      'tiempos': tiempos,
      'correcto': correcto,
      'titubeo': titubeo,
      'dificultad': dificultad,
      "binLO0": getJsonfromMatrix(this.binLO0),
      "binLO1": getJsonfromMatrix(this.binLO1),
      "binLO2": getJsonfromMatrix(this.binLO2),
      "binLO3": getJsonfromMatrix(this.binLO3),
      "binLO4": getJsonfromMatrix(this.binLO4),
      "binPer": getJsonfromMatrix(this.binPer),
      "mulLO0": getJsonfromMatrix(this.mulLO0),
      "mulLO1": getJsonfromMatrix(this.mulLO1),
      "mulLO2": getJsonfromMatrix(this.mulLO2),
      "mulLO3": getJsonfromMatrix(this.mulLO3),
      "mulLO4": getJsonfromMatrix(this.mulLO4),
      "mulPer": getJsonfromMatrix(this.mulPer),
      "Intensities": this.jsonIntensities,
      "numLO": 5,
    };
  }

  writeObjectInFile(String path) {
    Map performanceVectorMap = this.toJson();
    File('$path/PerformanceVectors.json')
        .writeAsStringSync(json.encode(performanceVectorMap));
  }

  factory PerformanceVectors.readObjectFromFile(String path) {
    File file = File('$path/PerformanceVectors.json');
    if (file.existsSync()) {
      Map performanceVectorMap = json.decode(file.readAsStringSync());
      PerformanceVectors myPerformanceVector = PerformanceVectors();
      myPerformanceVector.learningObjectives =
          List.of(performanceVectorMap["LO"].cast<int>());
      myPerformanceVector.grado = performanceVectorMap["grado"];
      myPerformanceVector.sesion = performanceVectorMap["sesion"];
      myPerformanceVector.tipoEscuela = performanceVectorMap["tipoEscuela"];
      myPerformanceVector.tiempos =
          List.of(performanceVectorMap["tiempos"].cast<int>());
      myPerformanceVector.correcto =
          List.of(performanceVectorMap["correcto"].cast<int>());
      myPerformanceVector.titubeo =
          List.of(performanceVectorMap["titubeo"].cast<int>());
      myPerformanceVector.dificultad =
          List.of(performanceVectorMap["dificultad"].cast<int>());
      myPerformanceVector.binLO0 =
          getMatrixfromJson(performanceVectorMap["binLO0"]);
      myPerformanceVector.binLO1 =
          getMatrixfromJson(performanceVectorMap["binLO1"]);
      myPerformanceVector.binLO2 =
          getMatrixfromJson(performanceVectorMap["binLO2"]);
      myPerformanceVector.binLO3 =
          getMatrixfromJson(performanceVectorMap["binLO3"]);
      myPerformanceVector.binLO4 =
          getMatrixfromJson(performanceVectorMap["binLO4"]);
      myPerformanceVector.binPer =
          getMatrixfromJson(performanceVectorMap["binPer"]);
      myPerformanceVector.mulLO0 =
          getMatrixfromJson(performanceVectorMap["mulLO0"]);
      myPerformanceVector.mulLO1 =
          getMatrixfromJson(performanceVectorMap["mulLO1"]);
      myPerformanceVector.mulLO2 =
          getMatrixfromJson(performanceVectorMap["mulLO2"]);
      myPerformanceVector.mulLO3 =
          getMatrixfromJson(performanceVectorMap["mulLO3"]);
      myPerformanceVector.mulLO4 =
          getMatrixfromJson(performanceVectorMap["mulLO4"]);
      myPerformanceVector.mulPer =
          getMatrixfromJson(performanceVectorMap["mulPer"]);
      myPerformanceVector.jsonIntensities = performanceVectorMap["Intensities"];
      myPerformanceVector.numLO = 5;
      return myPerformanceVector;
    } else {
      return null;
    }
  }

  static void writeJsonInFile(Map map) {
    File('$localPath/PerformanceVectors.json')
        .writeAsStringSync(json.encode(map));
  }

  getIntensitiesOfJson(Map performanceVectorsMap) {
    return performanceVectorsMap['Intensities'];
  }
}
