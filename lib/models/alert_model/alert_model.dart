class NotificationModel {
  final String type;
  final String message;

  NotificationModel({required this.type, required this.message});

  // Factory constructor to create a NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      type: json['type'] as String,
      message: json['message'] as String,
    );
  }

  // Convert NotificationModel to a Map (to send data back to the API if needed)
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
    };
  }
}

class NotificationsResponse {
  final bool success;
  final List<NotificationModel> notifications;
  final String message;

  NotificationsResponse({
    required this.success,
    required this.notifications,
    required this.message,
  });

  // Factory constructor to create NotificationsResponse from JSON
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] as bool,
      notifications: (json['data'] as List)
          .map((item) => NotificationModel.fromJson(item))
          .toList(),
      message: json['message'] as String,
    );
  }

  // Convert NotificationsResponse to a Map (for future use)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': notifications.map((notification) => notification.toJson()).toList(),
      'message': message,
    };
  }
}
