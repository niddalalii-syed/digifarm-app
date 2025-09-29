class NPKGraphData {
  NPKGraphData({
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.yScale,
  });

  late final List<double> nitrogen;
  late final List<double> phosphorus;
  late final List<double> potassium;
  late final List<double> yScale;

  NPKGraphData.fromJson(Map<String, dynamic> json) {
    // Safely parse lists and handle unexpected types
    nitrogen = (json['data']['y_values']['nitrogen'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    phosphorus = (json['data']['y_values']['phosphorus'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    potassium = (json['data']['y_values']['potassium'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    yScale = (json['data']['y_scale'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'y_values': {
          'nitrogen': nitrogen,
          'phosphorus': phosphorus,
          'potassium': potassium,
        },
        'y_scale': yScale,
      },
    };
  }
}


// class NPKGraphData {
//   NPKGraphData({
//     required this.nitrogen,
//     required this.phosphorus,
//     required this.potassium,
//     required this.yScale,
//   });
//
//   late final List<double> nitrogen;
//   late final List<double> phosphorus;
//   late final List<double> potassium;
//   late final List<double> yScale;
//
//   NPKGraphData.fromJson(Map<String, dynamic> json) {
//     nitrogen = List<double>.from(json['data']['y_values']['nitrogen']);
//     phosphorus = List<double>.from(json['data']['y_values']['phosphorus']);
//     potassium = List<double>.from(json['data']['y_values']['potassium']);
//     yScale = List<double>.from(json['data']['y_scale']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['y_values'] = {
//       'nitrogen': nitrogen,
//       'phosphorus': phosphorus,
//       'potassium': potassium,
//     };
//     _data['y_scale'] = yScale;
//     return _data;
//   }
// }
