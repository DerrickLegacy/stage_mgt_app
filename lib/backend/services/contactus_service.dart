import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_mgt_app/backend/interfaces/contactus_controller.dart';

class ContactUsService extends ContactUsController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> sendMessage(Map<String, dynamic> messageDetails) async {
    try {
      await _db.collection("contactMessages").add(messageDetails);
    } catch (e) {
      print(e);
    }
  }
}
