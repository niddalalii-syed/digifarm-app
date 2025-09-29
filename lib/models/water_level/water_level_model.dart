class WaterLevel {
  WaterLevel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final WaterData data;
  late final String message;

  WaterLevel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = WaterData.fromJson(json['data']);
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

class WaterData {
  WaterData({
    required this.avgValue,
    required this.data,
  });
  late final int avgValue;
  late final List<WaterDataItem> data;

  WaterData.fromJson(Map<String, dynamic> json) {
    avgValue = json['avg_value'];
    data = List.from(json['data']).map((e) => WaterDataItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['avg_value'] = avgValue;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class WaterDataItem {
  WaterDataItem({
    required this.status,
    required this.value,
  });
  late final String status;
  late final int value;

  WaterDataItem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['value'] = value;
    return _data;
  }
}
