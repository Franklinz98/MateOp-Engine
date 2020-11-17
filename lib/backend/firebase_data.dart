// Fetch performance data saved on database
import 'dart:convert';
import 'dart:io';
import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/models/user.dart';

Map getPerformanceData(MOUser user) {
  File file =
      getLocalFile('$localPath/data/performance', 'session${user.session}');
  if (file.existsSync()) {
    var jsonString = file.readAsStringSync();
    if (jsonString.isEmpty) {
      var asasfd = file.readAsStringSync();
      print(asasfd);
    }
    return json.decode(jsonString);
  } else {
    return null;
  }
  // Read performance file
}

// Post performance data
void updatePerformanceData(MOUser user, Map performanceVectorsData) {
  File file = getLocalFile(
      '$localPath/data/performance/', 'session${user.session}');
  var directory = Directory('$localPath/data/performance/');
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  if (!file.existsSync()) {
    file.createSync();
  }
  file.writeAsStringSync(json.encode(performanceVectorsData));
}
