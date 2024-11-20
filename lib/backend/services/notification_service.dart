import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_mgt_app/backend/interfaces/notification_controller.dart';
import 'package:stage_mgt_app/backend/models/notification.dart';

class NotificationService implements INotification {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch notifications for a specific user
  @override
  Future<List<NotificationModel>> getNotifications(String userId) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      return NotificationModel.fromMap(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Fetch a specific notification by document ID
  @override
  Future<NotificationModel?> getSpecificNotification(
      String userId, String docId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('notifications').doc(docId).get();

    if (snapshot.exists) {
      final notificationData = snapshot.data() as Map<String, dynamic>;
      if (notificationData['userId'] == userId) {
        return NotificationModel.fromMap(notificationData, snapshot.id);
      }
    }
    return null;
  }

  // Fetch all notifications (for admin or general use)
  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    QuerySnapshot snapshot = await _firestore.collection('notifications').get();

    return snapshot.docs.map((doc) {
      return NotificationModel.fromMap(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Create a new notification
  @override
  Future<void> createNotification(NotificationModel notification) async {
    await _firestore.collection('notifications').add(notification.toMap());
  }

  // Update an existing notification
  @override
  Future<void> updateNotification(NotificationModel notification) async {
    await _firestore
        .collection('notifications')
        .doc(notification.docId)
        .update(notification.toMap());
  }

  // Delete a notification by document ID
  @override
  Future<void> deleteNotification(String docId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(docId)
        .delete();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isNew': false,
      'readTimestamp': FieldValue.serverTimestamp(),
    });
  }
}
