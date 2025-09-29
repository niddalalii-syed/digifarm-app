class PHLevel {
  PHLevel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<Data> data;
  late final String message;

  PHLevel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.date,
    required this.phValue,
  });
  late final String date;
  late final double phValue; // Updated from int to double

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    phValue = (json['ph_value'] is int) // Safely handle both int and double
        ? (json['ph_value'] as int).toDouble()
        : json['ph_value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['ph_value'] = phValue;
    return _data;
  }
}


// class PHLevel {
//   PHLevel({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final List<Data> data;
//   late final String message;
//
//   PHLevel.fromJson(Map<String, dynamic> json){
//     success = json['success'];
//     data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     _data['message'] = message;
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.date,
//     required this.phValue,
//   });
//   late final String date;
//   late final int phValue;
//
//   Data.fromJson(Map<String, dynamic> json){
//     date = json['date'];
//     phValue = json['ph_value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['date'] = date;
//     _data['ph_value'] = phValue;
//     return _data;
//   }
// }