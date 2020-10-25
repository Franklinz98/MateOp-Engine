import 'dart:io';
import 'package:path/path.dart' as path;

final _filePath = '${path.current}/lib/json';

String get localPath {
  return _filePath;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}
