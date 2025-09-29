class C02Data {
  C02Data({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;

  C02Data.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    data = Data.fromJson(json['data'] ?? {});
    message = json['message'] ?? '';
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
  final int avgValue;
  final List<DataItem> data;

  Data({
    required this.avgValue,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var dataList = List.from(json['data'])
        .map((item) => DataItem.fromJson(item)) // Map each element to DataItem
        .toList();

    return Data(
      avgValue: json['avg_value'],
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avg_value': avgValue,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DataItem {
  final String? status;
  final int value;

  DataItem({
    required this.status,
    required this.value,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      status: json['status'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'value': value,
    };
  }
}

