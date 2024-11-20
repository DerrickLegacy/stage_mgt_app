import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_mgt_app/backend/models/contactus.dart';
import 'package:stage_mgt_app/backend/interfaces/contactus_controller.dart';

class ContactUsService extends ContactUsController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to send a message
  @override
  Future<void> sendMessage(Map<String, dynamic> messageDetails) async {
    try {
      await _db.collection("contactMessages").add(messageDetails);
    } catch (e) {
      print(e);
    }
  }

  Future<List<ContactUs>> fetchAllRequests() async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection("contactMessages").get();

      List<ContactUs> requests = querySnapshot.docs.map((doc) {
        return ContactUs(
          docId: doc.id,
          phoneNumber: doc['phoneNumber'],
          emailAddress: doc['emailAddress'],
          userId: doc['userId'],
          username: doc['username'],
          title: doc['title'],
          message: doc['message'],
          isReadByAdmin: doc['isReadByAdmin'] ?? false,
        );
      }).toList();

      return requests;
    } catch (e) {
      print("Error fetching requests: $e");
      return [];
    }
  }

  Future<void> markAsRead(String docId) async {
    try {
      await _db.collection("contactMessages").doc(docId).update({
        'isReadByAdmin': true,
        'readTimestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error marking as read: $e");
    }
  }
}
