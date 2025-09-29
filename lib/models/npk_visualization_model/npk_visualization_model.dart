class NPKVisualization {
  NPKVisualization({
    required this.success,
    required this.data,
    required this.message,
  });

  late final bool success;
  late final Data data;
  late final String message;

  NPKVisualization.fromJson(Map<String, dynamic> json) {
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
    required this.yValues,
    required this.yScale,
  });

  late final List<double> yValues;
  late final List<double> yScale;

  Data.fromJson(Map<String, dynamic> json) {
    yValues = List<double>.from(json['y_values'].map((x) => x.toDouble()));
    yScale = List<double>.from(json['y_scale'].map((x) => x.toDouble()));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['y_values'] = yValues;
    _data['y_scale'] = yScale;
    return _data;
  }
}


// class NPKVisualization {
//   NPKVisualization({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final Data data;
//   late final String message;
//
//   NPKVisualization.fromJson(Map<String, dynamic> json){
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
//     required this.yValues,
//     required this.yScale,
//   });
//   late final List<int> yValues;
//   late final List<int> yScale;
//
//   Data.fromJson(Map<String, dynamic> json){
//     yValues = List.castFrom<dynamic, int>(json['y_values']);
//     yScale = List.castFrom<dynamic, int>(json['y_scale']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['y_values'] = yValues;
//     _data['y_scale'] = yScale;
//     return _data;
//   }
// }