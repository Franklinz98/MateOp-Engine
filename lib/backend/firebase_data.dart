// Fetch performance data saved on database
import 'dart:convert';
import 'dart:io';
import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/models/user.dart';

Future<Map> getPerformanceData(MOUser user) async {
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
Future<void> updatePerformanceData(
    MOUser user, Map performanceVectorsData) async {
  File file = getLocalFile(
      '$localPath/data/performance/', 'session${user.session + 1}');
  var directory = Directory('$localPath/data/performance/');
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  if (!file.existsSync()) {
    file.createSync();
  }
  file.writeAsStringSync(json.encode(performanceVectorsData));
}
