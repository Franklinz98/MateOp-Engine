import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

final _filePath = '${path.current}/lib/json';

String get localPath {
  return _filePath;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
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
