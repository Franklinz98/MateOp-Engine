import 'dart:convert';
import 'dart:io';
import 'package:mateop_engine/models/exercise_manager.dart';
import 'package:mateop_engine/models/user.dart';
import 'package:path/path.dart' as path;

final _filePath = '${path.current}/lib/json';

String get localPath {
  return _filePath;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}

Future<void> writeSessionFile(
    ExerciseManager exerciseManager, MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.uid}";
  File file = getLocalFile(path, filename);
  file.writeAsStringSync(json.encode(exerciseManager.toJson()),
      mode: FileMode.write);
}

Future<ExerciseManager> readSessionFile(MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.uid}";
  File file = getLocalFile(path, filename);
  return ExerciseManager.fromJson(json.decode(file.readAsStringSync()));
}

Future<void> deleteSessionFile(MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.uid}";
  File file = getLocalFile(path, filename);
  file.deleteSync();
}

Future<bool> setTimes() {
  Map map = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
  };
  List<Map> los = [];
  los.add(map);
  los.add(map);
  los.add(map);
  los.add(map);
  los.add(map);
  File file0 = getLocalFile(_filePath, 'time_data_0');
  File file1 = getLocalFile(_filePath, 'time_data_1');
  file0.writeAsStringSync(json.encode({'data': los, 'metadata': los}),
      mode: FileMode.write);
  file1.writeAsStringSync(json.encode({'data': los, 'metadata': los}),
      mode: FileMode.write);
}

Future<Map> getAverageTimes(int schoolType) async {
  File file = getLocalFile(_filePath, 'time_data_$schoolType');
  return json.decode(file.readAsStringSync());
}

Future<void> setAverageTimes(Map map, int schoolType) async {
  File file = getLocalFile(_filePath, 'time_data_$schoolType');
  file.writeAsStringSync(json.encode(map), mode: FileMode.write);
}
