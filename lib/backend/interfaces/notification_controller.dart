// blueprint file
import 'package:stage_mgt_app/backend/models/notification.dart';

abstract class INotification {
  Future<List<NotificationModel>> getNotifications(String currentUserId);
  Future<NotificationModel?> getSpecificNotification(
      String userId, String notificationId);
  Future<List<NotificationModel>> getAllNotifications();
  Future<void> createNotification(NotificationModel notification);
  Future<void> updateNotification(NotificationModel notification);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String id);
  Future<void> createBookingReminder();
}
