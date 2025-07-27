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