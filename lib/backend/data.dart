import 'dart:io';

final _filePath = 'D:/Users/mybas/Documents/DartProjects/mateop_engine/lib/json';

String get localPath {
  return _filePath;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}
