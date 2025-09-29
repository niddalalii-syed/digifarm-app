class NKPLevels {
  NKPLevels({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;

  NKPLevels.fromJson(Map<String, dynamic> json) {
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
    required this.nitogenLevel,
    required this.nitrogen,
    required this.phosphorusLevel,
    required this.phosphorus,
    required this.potassiumLevel,
    required this.potassium,
    required this.nitrogenDescription,
    required this.phosphorusDescription,
    required this.potassiumDescription,
  });
  late final double nitogenLevel;
  late final int nitrogen;
  late final double phosphorusLevel;
  late final int phosphorus;
  late final double potassiumLevel;
  late final int potassium;
  late final String nitrogenDescription;
  late final String phosphorusDescription;
  late final String potassiumDescription;

  Data.fromJson(Map<String, dynamic> json) {
    // Safely parse mixed data types
    nitogenLevel = (json['nitogen_level'] as num).toDouble();
    nitrogen = (json['nitrogen'] as num).toInt();
    phosphorusLevel = (json['phosphorus_level'] as num).toDouble();
    phosphorus = (json['phosphorus'] as num).toInt();
    potassiumLevel = (json['potassium_level'] as num).toDouble();
    potassium = (json['potassium'] as num).toInt();
    nitrogenDescription = json['nitrogen_description'];
    phosphorusDescription = json['phosphorus_description'];
    potassiumDescription = json['potassium_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nitogen_level'] = nitogenLevel;
    _data['nitrogen'] = nitrogen;
    _data['phosphorus_level'] = phosphorusLevel;
    _data['phosphorus'] = phosphorus;
    _data['potassium_level'] = potassiumLevel;
    _data['potassium'] = potassium;
    _data['nitrogen_description'] = nitrogenDescription;
    _data['phosphorus_description'] = phosphorusDescription;
    _data['potassium_description'] = potassiumDescription;
    return _data;
  }
}



// class NKPLevels {
//   NKPLevels({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final Data data;
//   late final String message;
//
//   NKPLevels.fromJson(Map<String, dynamic> json){
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
//     required this.nitogenLevel,
//     required this.nitrogen,
//     required this.phosphorusLevel,
//     required this.phosphorus,
//     required this.potassiumLevel,
//     required this.potassium,
//     required this.nitrogenDescription,
//     required this.phosphorusDescription,
//     required this.potassiumDescription,
//   });
//   late final double nitogenLevel;
//   late final int nitrogen;
//   late final double phosphorusLevel;
//   late final int phosphorus;
//   late final double potassiumLevel;
//   late final int potassium;
//   late final String nitrogenDescription;
//   late final String phosphorusDescription;
//   late final String potassiumDescription;
//
//   Data.fromJson(Map<String, dynamic> json){
//     nitogenLevel = json['nitogen_level'];
//     nitrogen = json['nitrogen'];
//     phosphorusLevel = json['phosphorus_level'];
//     phosphorus = json['phosphorus'];
//     potassiumLevel = json['potassium_level'];
//     potassium = json['potassium'];
//     nitrogenDescription = json['nitrogen_description'];
//     phosphorusDescription = json['phosphorus_description'];
//     potassiumDescription = json['potassium_description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['nitogen_level'] = nitogenLevel;
//     _data['nitrogen'] = nitrogen;
//     _data['phosphorus_level'] = phosphorusLevel;
//     _data['phosphorus'] = phosphorus;
//     _data['potassium_level'] = potassiumLevel;
//     _data['potassium'] = potassium;
//     _data['nitrogen_description'] = nitrogenDescription;
//     _data['phosphorus_description'] = phosphorusDescription;
//     _data['potassium_description'] = potassiumDescription;
//     return _data;
//   }
// }