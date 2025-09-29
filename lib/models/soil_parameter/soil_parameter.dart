class SoilParameter {
  SoilParameter({
    required this.success,
    required this.data,
    required this.message,
  });

  late final bool success;
  late final Data data;
  late final String message;

  SoilParameter.fromJson(Map<String, dynamic> json) {
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
    required this.ph,
    required this.conductivity,
  });

  late final double temperature;
  late final double humidity;
  late final double ph; // Updated to double
  late final double conductivity; // Updated to double

  Data.fromJson(Map<String, dynamic> json) {
    temperature = (json['temperature'] as num).toDouble();
    humidity = (json['humidity'] as num).toDouble();
    ph = (json['ph'] as num).toDouble(); // Handles both int and double
    conductivity = (json['conductivity'] as num).toDouble(); // Handles both int and double
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temperature'] = temperature;
    _data['humidity'] = humidity;
    _data['ph'] = ph;
    _data['conductivity'] = conductivity;
    return _data;
  }
}


// class SoilParameter {
//   SoilParameter({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final Data data;
//   late final String message;
//
//   SoilParameter.fromJson(Map<String, dynamic> json){
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
//     required this.ph,
//     required this.conductivity,
//   });
//   late final double temperature;
//   late final double humidity;
//   late final int ph;
//   late final int conductivity;
//
//   Data.fromJson(Map<String, dynamic> json){
//     temperature = json['temperature'];
//     humidity = json['humidity'];
//     ph = json['ph'];
//     conductivity = json['conductivity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['temperature'] = temperature;
//     _data['humidity'] = humidity;
//     _data['ph'] = ph;
//     _data['conductivity'] = conductivity;
//     return _data;
//   }
// }