
import 'package:digifarm_new/models/alert_model/alert_model.dart';
import 'package:digifarm_new/models/nkp_levels/nkp_levels_model.dart';
import 'package:digifarm_new/models/npk_graph/npk_graph.dart';
import 'package:digifarm_new/models/npk_model/npk_model.dart';
import 'package:digifarm_new/models/npk_score/npk_score.dart';
import 'package:digifarm_new/models/npk_visualization_model/npk_visualization_model.dart';
import 'package:digifarm_new/models/ph_level_model/ph_level_model.dart';
import 'package:digifarm_new/models/predictive_analysis/predictive_analysis.dart';
import 'package:digifarm_new/models/soil_c02_level/soil_c02_level.dart';
import 'package:digifarm_new/models/soil_parameter/soil_parameter.dart';
import 'package:digifarm_new/models/temp_humid_forcast/temp_humid_forcast.dart';
import 'package:digifarm_new/models/water_level/water_level_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class API_Services {

  // String baseUrl = 'http://localhost:8000';
  String baseUrl = 'https://dda6-39-34-137-96.ngrok-free.app';


  // Fetch NPK Data from API
  Future<NPKData> fetchNPKData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/npk-data'),
      headers: {
        "ngrok-skip-browser-warning": "69420",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return NPKData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load NPK data');
    }
  }

  // Future<NPKData> fetchNPKData() async {
  //   final response = await http.get(Uri.parse('$baseUrl/api/v1/npk-data'));
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     return NPKData.fromJson(jsonResponse);
  //   } else {
  //     throw Exception('Failed to load NPK data');
  //   }
  // }

  // Fetch PH Data from API
  Future<PHLevel> fetchPHData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/ph-data?current=0'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PHLevel.fromJson(jsonResponse);  // Return PHLevel object after decoding JSON
    } else {
      throw Exception('Failed to load PH data');
    }
  }

  // Function to fetch the predictive analysis data
  Future<PredictiveAnalysisData> fetchPredictiveAnalysisData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/predictive-analysis'));
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PredictiveAnalysisData.fromJson(jsonResponse['data']); // Return the data part
    } else {
      throw Exception('Failed to load predictive analysis data');
    }
  }


  // Function to fetch NPK graph data Combined 1
  Future<NPKVisualization> fetchNPKGraphData1() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/npk-graph?combined=1'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return NPKVisualization.fromJson(jsonData);
      } else {
        throw Exception('Failed to load NPK graph data');
      }
    } catch (e) {
      throw Exception('Error fetching NPK data: $e');
    }
  }

  // Function to fetch NPK Graph data Combined 0
  Future<NPKGraphData> fetchNPKGraphData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/npk-graph?combined=0'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return NPKGraphData.fromJson(jsonResponse); // Return the parsed NPK data
    } else {
      throw Exception('Failed to load NPK graph data');
    }
  }

  // Fetch temperature and humidity forecast data
  Future<TempHumidForcast> fetchTempHumidForcast() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/t-h-data'));

      if (response.statusCode == 200) {
        // If the response is successful, parse the JSON data
        return TempHumidForcast.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load temperature and humidity data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Fetch soil data
  Future<SoilParameter> fetchSoilData() async {
    final url = Uri.parse('$baseUrl/api/v1/soil-data');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body);
        return SoilParameter.fromJson(responseJson);
      } else {
        throw Exception('Failed to load soil data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching soil data');
    }
  }

  // Fetch NPK Level data
  Future<NKPLevels> fetchNpkLevels() async {
    final url = Uri.parse('$baseUrl/api/v1/npk-data/details');
    try {
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return NKPLevels.fromJson(data);
      } else {
        throw Exception('Failed to load NPK levels');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching NPK levels');
    }
  }


  // Function for soil CO2 level data
  Future<C02Data> fetchCO2Data() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/co2-data'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return C02Data.fromJson(json.decode(response.body));
    } else {
      // If the server does not return a successful response, throw an exception.
      throw Exception('Failed to load CO2 data');
    }
  }

  // Function to fetch water level data
  Future<WaterLevel> fetchWaterLevelData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/h2o-data'));

    if (response.statusCode == 200) {
      return WaterLevel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load water level data');
    }
  }

  // Method to fetch notifications
  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/notifications'));

    if (response.statusCode == 200) {
      final notificationsResponse = NotificationsResponse.fromJson(json.decode(response.body));
      return notificationsResponse.notifications;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  // Function to fetch NPK score from the backend API
  Future<NPKScore> getNPKScore() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/home/score'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success']) {
        return NPKScore.fromJson(data['data']);
      } else {
        throw Exception('Failed to load NPK score');
      }
    } else {
      throw Exception('Failed to load NPK score');
    }
  }

}
