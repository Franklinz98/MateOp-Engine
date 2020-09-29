import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mateop_engine/models/intensities.dart';
import 'package:mateop_engine/models/user.dart';

const String baseUrl = 'mate-op.herokuapp.com';

// Calculate next intensity level with the bayesian model
Future<Intensity> getNextIntensityLevel(Map map) async {
  var uri = Uri.https(baseUrl, 'nextIntensity');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(map),
  );
  if (response.statusCode == 200) {
    var intensity =
        Intensity.fromJson(json.decode(response.body)['Intensities']);
    return intensity;
  } else {
    throw Exception('Error on request');
  }
}

// Calculate initial intensity level with the bayesian model using user metadata
Future<Intensity> predictInicitalIntensity(MOUser user) async {
  var uri = Uri.https(baseUrl, 'onNewPlayer');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(user.toJsonPrediction()),
  );
  if (response.statusCode == 200) {
    var intensity = Intensity.fromJson(json.decode(response.body));
    return intensity;
  } else {
    throw Exception('Error on request');
  }
}
