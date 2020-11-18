import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mateop_engine/backend/data.dart';
import 'package:mateop_engine/backend/firebase_data.dart';
import 'package:mateop_engine/models/intensities.dart';
import 'package:mateop_engine/models/performance_vectors.dart';
import 'package:mateop_engine/models/user.dart';

const String baseUrl = 'mate-op.herokuapp.com';
// const String baseUrl = 'localhost:3000';

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
    var updatedPerformance = json.decode(response.body);
    var intensity = Intensity.fromJson(updatedPerformance['Intensities']);
    PerformanceVectors currentPerformanceVectors =
        PerformanceVectors.fromJson(map);
    currentPerformanceVectors.setBinLoPerformanceVectors(
        updatedPerformance['binLO0'],
        updatedPerformance['binLO1'],
        updatedPerformance['binLO2'],
        updatedPerformance['binLO3'],
        updatedPerformance['binLO4']);
    currentPerformanceVectors
        .setBinperPerformanceVectors(updatedPerformance['binPer']);
    currentPerformanceVectors.setMulLoformanceVectors(
        updatedPerformance['mulLO0'],
        updatedPerformance['mulLO1'],
        updatedPerformance['mulLO2'],
        updatedPerformance['mulLO3'],
        updatedPerformance['mulLO4']);
    currentPerformanceVectors
        .setMulPerPerformanceVectors(updatedPerformance['mulPer']);
    currentPerformanceVectors.setIntensities(intensity.toJson);
    currentPerformanceVectors.writeObjectInFile(localPath);
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
