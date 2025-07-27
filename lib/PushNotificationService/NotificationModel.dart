class NotificationModel
{
  String? id;
  String? message;
  String? created_at;

  NotificationModel({this.id, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message']??"";
    created_at = json['created_at']??"";
  }

}

class NotificationsResponse {
  final List<NotificationModel> notifications;
  final int currentPage;
  final int lastPage;
  final int count;

  NotificationsResponse({
    required this.notifications,
    required this.currentPage,
    required this.lastPage,
    required this.count
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['unread_notifications'] as List)
        .map((item) => NotificationModel.fromJson(item))
        .toList();

    return NotificationsResponse(
      notifications: list,
      currentPage: json['pagination']['current_page'],
      lastPage: json['pagination']['last_page'],
      count: json['count_unread_notifications']
    );
  }
}
