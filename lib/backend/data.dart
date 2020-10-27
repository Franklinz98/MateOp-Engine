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
