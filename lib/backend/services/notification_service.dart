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
  @override
  Future<void> createBookingReminder() async {
    final DateTime now = DateTime.now();

    try {
      // Step 1: Fetch all bookings with future travel dates
      final QuerySnapshot snapshot =
          await _firestore.collection('bookings').get();

      for (var bookingDoc in snapshot.docs) {
        final Map<String, dynamic> bookingData =
            bookingDoc.data() as Map<String, dynamic>;

        // Combine `travelDate` and `travelTime` to create a DateTime object
        final String travelDate = bookingData['travelDate'];
        final String travelTime = bookingData['travelTime'];

        if (travelDate.isEmpty || travelTime.isEmpty) continue;

        // Parse travelDate and travelTime into a DateTime object
        final DateTime scheduledTime =
            DateTime.parse("$travelDate ${_formatTravelTime(travelTime)}");

        final Duration timeDifference = scheduledTime.difference(now);
        print("timeDifference");
        print(timeDifference);

        // Step 2: Check if booking matches the reminder criteria
        if (timeDifference.inDays == 1 || // 1 day
            timeDifference.inHours == 10 || // 10 hours
            timeDifference.inMinutes == 10) {
          // 10 minutes

          // Generate a unique ID for the notification
          final String notificationId =
              _firestore.collection('notifications').doc().id;

          // Step 3: Create the notification object
          final NotificationModel notification = NotificationModel(
            docId: notificationId,
            id: notificationId,
            userId: bookingData['userId'],
            title: "Travel Reminder",
            message:
                "Your trip from ${bookingData['from']} to ${bookingData['to']} "
                "is scheduled on ${scheduledTime.toLocal()} and is approaching.",
            time: now.toIso8601String(),
            isNew: true,
          );

          // Step 4: Save the notification to the `notifications` collection
          await _firestore
              .collection('notifications')
              .doc(notificationId)
              .set(notification.toMap());
        }
      }
    } catch (e) {
      print("Error in createBookingReminder: $e");
      rethrow; // Optional: Re-throw the error for higher-level handling
    }
  }

  String _formatTravelTime(String travelTime) {
    final RegExp timeRegExp =
        RegExp(r'(\d+):(\d+)\s*(AM|PM)', caseSensitive: false);
    final Match? match = timeRegExp.firstMatch(travelTime);

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      final String period = match.group(3)!.toUpperCase();

      if (period == "PM" && hour != 12) {
        hour += 12;
      } else if (period == "AM" && hour == 12) {
        hour = 0;
      }

      return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    }

    throw FormatException("Invalid time format: $travelTime");
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isNew': false,
      'readTimestamp': FieldValue.serverTimestamp(),
    });
  }
}
