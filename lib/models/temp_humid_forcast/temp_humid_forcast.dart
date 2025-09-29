class TempHumidForcast {
  TempHumidForcast({
    required this.success,
    required this.data,
    required this.message,
  });

  late final bool success;
  late final Data data;
  late final String message;

  TempHumidForcast.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.temperature,
    required this.humidity,
    required this.forecastData,
  });

  late final double temperature;
  late final double humidity;
  late final List<ForecastData> forecastData;

  Data.fromJson(Map<String, dynamic> json) {
    // Handle mixed types for temperature and humidity (int or double)
    temperature = (json['temperature'] as num).toDouble();
    humidity = (json['humidity'] as num).toDouble();

    // Parse forecast data
    forecastData = List.from(json['forecast_data'])
        .map((e) => ForecastData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temperature'] = temperature;
    _data['humidity'] = humidity;
    _data['forecast_data'] = forecastData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ForecastData {
  ForecastData({
    required this.date,
    required this.temperature,
    required this.humidity,
  });

  late final String date;
  late final double temperature; // Changed from nullable to non-nullable
  late final double humidity;

  ForecastData.fromJson(Map<String, dynamic> json) {
    date = json['date'];

    // Safely parse temperature and humidity
    temperature = (json['temperature'] as num).toDouble();
    humidity = (json['humidity'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['temperature'] = temperature;
    _data['humidity'] = humidity;
    return _data;
  }
}


// class TempHumidForcast {
//   TempHumidForcast({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final Data data;
//   late final String message;
//
//   TempHumidForcast.fromJson(Map<String, dynamic> json){
//     success = json['success'];
//     data = Data.fromJson(json['data']);
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data.toJson();
//     _data['message'] = message;
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.temperature,
//     required this.humidity,
//     required this.forecastData,
//   });
//   late final double temperature;
//   late final double humidity;
//   late final List<ForecastData> forecastData;
//
//   Data.fromJson(Map<String, dynamic> json){
//     temperature = json['temperature'];
//     humidity = json['humidity'];
//     forecastData = List.from(json['forecast_data']).map((e)=>ForecastData.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['temperature'] = temperature;
//     _data['humidity'] = humidity;
//     _data['forecast_data'] = forecastData.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class ForecastData {
//   ForecastData({
//     required this.date,
//     required this.temperature,
//     required this.humidity,
//   });
//   late final String date;
//   late final double? temperature;
//   late final int humidity;
//
//   ForecastData.fromJson(Map<String, dynamic> json){
//     date = json['date'];
//     temperature = json['temperature'];
//     humidity = json['humidity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['date'] = date;
//     _data['temperature'] = temperature;
//     _data['humidity'] = humidity;
//     return _data;
//   }
// }