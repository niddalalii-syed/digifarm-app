class NPKData {
  NPKData({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;

  NPKData.fromJson(Map<String, dynamic> json){
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
    required this.phosphorusLevel,
    required this.potassiumLevel,
    required this.ph,
  });
  late final double nitogenLevel;
  late final double phosphorusLevel;
  late final double potassiumLevel;
  late final double ph;

  Data.fromJson(Map<String, dynamic> json){
    nitogenLevel = json['nitogen_level'];
    phosphorusLevel = json['phosphorus_level'];
    potassiumLevel = json['potassium_level'];
    ph = json['ph'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nitogen_level'] = nitogenLevel;
    _data['phosphorus_level'] = phosphorusLevel;
    _data['potassium_level'] = potassiumLevel;
    _data['ph'] = ph;
    return _data;
  }
}