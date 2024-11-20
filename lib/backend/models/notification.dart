// Notification Model
class NotificationModel {
  final String docId;
  final String id;
  final String userId;
  final String title;
  final String message;
  final String time;
  bool isNew;

  NotificationModel({
    required this.docId,
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.time,
    this.isNew = false,
  });

  // Convert a NotificationModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'message': message,
      'time': time,
      'isNew': isNew ? 1 : 0,
    };
  }

  // Convert a Map into a NotificationModel object
  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      docId: id,
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      time: map['time'] ?? '',
      isNew: map['isNew'] == 1,
    );
  }
}
