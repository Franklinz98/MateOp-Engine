import 'dart:convert';
import 'dart:math';

import 'package:mateop_engine/enum/enums.dart';

import '../backend/data.dart';
import '../models/exercise.dart';
import '../models/saved_exercise.dart';
import '../models/intensities.dart';
import 'dart:io' as io;

List<Exercise> generateRandomExercise(
    int numberOfExercises, int minNumber, int maxNumber, OperationType type) {
  var myExercises = <Exercise>[];
  for (var i = 1; i <= numberOfExercises; i++) {
    var operator1 =
        minNumber + Random().nextInt(maxNumber - minNumber).toDouble();
    var operator2 =
        minNumber + Random().nextInt(maxNumber - minNumber).toDouble();
    myExercises.add(
      Exercise(
        firstOperator: operator1,
        secondOperator: operator2,
        answer: calculateAnswer(operator1, operator2, type),
      ),
    );
  }
  return myExercises;
}

Future<List<Exercise>> generateExercisesFromLOPerformance(
    Intensity myPerformance, int numberOfExercises) async {
  List<Exercise> myExercises = List<Exercise>();

  int chosenLO = 0;
  int totalEx = 0;
  double comparator = -1;
  List<int> numberPerLo = List<int>();
  for (var i = 0; i < myPerformance.getNumberOfLo(); i++) {
    int numberExercPerLo =
        (numberOfExercises * myPerformance.loIntensities['LOIN$i']).toInt();
    numberPerLo.add(numberExercPerLo);
    totalEx = totalEx + numberExercPerLo;
    if (comparator < myPerformance.loIntensities['LOIN$i']) {
      comparator = myPerformance.loIntensities['LOIN$i'];
      chosenLO = i;
    }
  }

  if (numberOfExercises > totalEx) {
    numberPerLo[chosenLO] =
        numberPerLo[chosenLO] + (numberOfExercises - totalEx).abs();
  } else if (numberOfExercises < totalEx) {
    numberPerLo[chosenLO] =
        numberPerLo[chosenLO] - (numberOfExercises - totalEx).abs();
  }

  for (var i = 0; i < myPerformance.getNumberOfLo(); i++) {
    int numberOfDF =
        (numberPerLo[i] * myPerformance.loIntensities["LOINDF$i"]).toInt();
    int numberOfDD =
        (numberPerLo[i] * myPerformance.loIntensities["LOINDD$i"]).toInt();
    if (numberOfDD + numberOfDF != numberPerLo[i]) {
      if (myPerformance.loIntensities["LOINDF$i"] >
          myPerformance.loIntensities["LOINDD$i"]) {
        numberOfDF =
            numberOfDF + (numberOfDD + numberOfDF - numberPerLo[i]).abs();
      } else {
        numberOfDD =
            numberOfDD + (numberOfDD + numberOfDF - numberPerLo[i]).abs();
      }
    }

    List<Exercise> myExerciseslo = await _generateExercisesPerLO(
        numberOfDF, "LOIN$i", 0, OperationType.addition);
    for (Exercise ex in myExerciseslo) {
      myExercises.add(ex);
    }
    myExerciseslo = await _generateExercisesPerLO(
        numberOfDD, "LOIN$i", 1, OperationType.addition);
    for (Exercise ex in myExerciseslo) {
      myExercises.add(ex);
    }
  }

  return myExercises;
}

bool _canBeAddedToList(List<int> list, int newNum, int comparator) {
  int count = 0;
  for (int a in list) {
    if (a == newNum) {
      count++;
    }
  }
  if (count >= comparator) {
    return false;
  }
  return true;
}

Future<List<Exercise>> _generateExercisesPerLO(int numberExerc,
    String loIDString, int dificulty, OperationType opType) async {
  List<Exercise> myExercises = List<Exercise>();
  List<int> choosenNumbersSum1 = List<int>();
  List<int> choosenNumbersSum2 = List<int>();
  myExercises =
      await _getPastExercisesFromFile(numberExerc, loIDString, dificulty);
  numberExerc = numberExerc - myExercises.length;
  for (var i = 0; i < numberExerc; i++) {
    int loId = 0;
    int sumOp1 = 0, sumOp2 = 0;
    if (loIDString == "LOIN0") {
      loId = 0;
      if (dificulty == 1) {
        do {
          sumOp1 = Random().nextInt(10) + 1;
          sumOp2 = Random().nextInt(10) + 1;
        } while (sumOp1 + sumOp2 < 10 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      } else {
        do {
          sumOp1 = Random().nextInt(10) + 1;
          sumOp2 = Random().nextInt(10) + 1;
        } while ((sumOp1 + sumOp2) >= 10 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      }
    } else if (loIDString == "LOIN1") {
      loId = 1;
      sumOp2 = 10;
      if (dificulty == 1) {
        do {
          sumOp1 = Random().nextInt(10) + 5;
        } while ((sumOp1 + sumOp2) <= 15 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2));
      } else {
        do {
          sumOp1 = Random().nextInt(5) + 1;
        } while ((sumOp1 + sumOp2) > 15 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2));
      }
    } else if (loIDString == "LOIN2") {
      loId = 2;
      if (dificulty == 1) {
        do {
          sumOp1 = Random().nextInt(10) + 1;
          sumOp2 = Random().nextInt(100) + 10;
        } while (sumOp1 + sumOp2 >= 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      } else {
        do {
          sumOp1 = Random().nextInt(100) + 10;
          sumOp2 = Random().nextInt(10) + 1;
        } while (sumOp1 + sumOp2 >= 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      }
    } else if (loIDString == "LOIN3") {
      loId = 3;
      if (dificulty == 1) {
        do {
          sumOp1 = Random().nextInt(10) + 1;
          sumOp2 = Random().nextInt(100) + 10;
        } while (sumOp1 + sumOp2 < 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      } else {
        do {
          sumOp1 = Random().nextInt(100) + 10;
          sumOp2 = Random().nextInt(10) + 1;
        } while (sumOp1 + sumOp2 < 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      }
    } else {
      loId = 4;
      if (dificulty == 1) {
        do {
          sumOp1 = Random().nextInt(100) + 10;
          sumOp2 = Random().nextInt(100) + 10;
        } while (sumOp1 + sumOp2 < 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      } else {
        do {
          sumOp1 = Random().nextInt(100) + 10;
          sumOp2 = Random().nextInt(100) + 10;
        } while (sumOp1 + sumOp2 >= 100 ||
            !_canBeAddedToList(choosenNumbersSum1, sumOp1, 2) ||
            !_canBeAddedToList(choosenNumbersSum2, sumOp2, 2) ||
            !_canExerciseBeAdded(myExercises, sumOp1, sumOp2));
      }
    }
    choosenNumbersSum1.add(sumOp1);
    choosenNumbersSum2.add(sumOp2);
    int type = 0;
    Exercise oneExc = Exercise(
      loID: loId,
      firstOperator: sumOp1.toDouble(),
      secondOperator: sumOp2.toDouble(),
      answer: calculateAnswer(sumOp1.toDouble(), sumOp2.toDouble(), opType),
      operation: opType,
    );
    oneExc.dificulty = dificulty;
    myExercises.add(oneExc);
  }
  return myExercises;
}

Future<List<Exercise>> _getPastExercisesFromFile(
    int numberExerc, String loIDString, int dificulty) async {
  List<Exercise> myExercises = List<Exercise>();
  String path = await localPath;
  String filename = "WrongExercises";
  io.File file = getLocalFile(path, filename);
  try {
    List<Map> savedExercises = jsonDecode(await file.readAsString());
    List<Map> tempSavedExercises = List();
    savedExercises.forEach((savedExerciseMap) {
      SavedExercise savedExercise = SavedExercise.fromJson(savedExerciseMap);
      if (savedExercise.intensity == loIDString &&
          savedExercise.dificulty == dificulty &&
          myExercises.length < numberExerc) {
        Exercise previewExercise = savedExercise.exercise;
        myExercises.add(previewExercise);
      } else {
        tempSavedExercises.add(savedExercise.toJson());
      }
      file.writeAsString(jsonEncode(tempSavedExercises),
          mode: io.FileMode.write);
    });
  } catch (e) {
    // If we encounter an error, return 0
  }
  return myExercises;
}

writeOnFIleWrongExercise(Exercise myWrongExercise) async {
  String path = await localPath;
  String filename = "WrongExercises";
  io.File file = getLocalFile(path, filename);
  int dificulty = _getDificultyOfExercise(myWrongExercise);
  SavedExercise savedExercise =
      SavedExercise("LOIN${myWrongExercise.loID}", dificulty, myWrongExercise);
  try {
    List<Map> savedExercises = jsonDecode(await file.readAsString());
    savedExercises.add(savedExercise.toJson());
    file.writeAsString(jsonEncode(savedExercises), mode: io.FileMode.write);
  } catch (e) {
    // If we encounter an error, return 0
  }
}

int _getDificultyOfExercise(Exercise myExercise) {
  double sumOp1 = myExercise.firstOperator;
  double sumOp2 = myExercise.secondOperator;

  if (myExercise.loID == 0) {
    if (sumOp1 + sumOp2 >= 10) {
      return 1;
    } else {
      return 0;
    }
  } else if (myExercise.loID == 1) {
    return 0;
  } else if (myExercise.loID == 2) {
    if (sumOp1 + sumOp2 >= 100) {
      return 1;
    } else {
      return 0;
    }
  } else if (myExercise.loID == 3) {
    return 0;
  } else {
    if (sumOp1 + sumOp2 >= 100) {
      return 1;
    } else {
      return 0;
    }
  }
}

bool _canExerciseBeAdded(List<Exercise> currents, int a, int b) {
  for (Exercise exercise in currents) {
    if (exercise.firstOperator == a && exercise.secondOperator == b) {
      return false;
    }
  }
  return true;
}

double getTotalPerformance(Intensity myperformance) {
  double result = 0;
  for (var i = 0; i < myperformance.getNumberOfLo(); i++) {
    result = result + myperformance.loIntensities["LOIN$i"];
  }
  return result;
}

double calculateAnswer(
    double firstOperator, double secondOperator, OperationType type) {
  switch (type) {
    case OperationType.addition:
      return firstOperator + secondOperator;
    case OperationType.subtraction:
      return firstOperator - secondOperator;
    case OperationType.multiplication:
      return firstOperator * secondOperator;
    default:
      return firstOperator / secondOperator;
  }
}

List<double> generateAnswerOptions(double answer) {
  int delta = (answer * Random().nextDouble()).round();
  if (delta == 0) {
    delta = 1;
  }
  double extraOption1 = answer - delta;
  double extraOption2 = answer + delta;
  List<double> allOptions = [answer, extraOption1, extraOption2];
  allOptions.shuffle();
  return allOptions;
}
