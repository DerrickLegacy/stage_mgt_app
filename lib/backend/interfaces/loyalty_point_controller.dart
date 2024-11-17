import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/loyalty_points_model.dart';

class LoyaltyPointsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestore collection reference
  CollectionReference get _collection => _firestore.collection('loyaltyPoints');

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

  // Create a new LoyaltyPoints document
  Future<void> createLoyaltyPoints(
      LoyaltyPoints points, String serviceType) async {
    int pointCounter = 0;
    try {
      if (serviceType == 'bookedRide') {
        pointCounter += pointCounter + 50;
      } else if (serviceType == 'walletTopUp') {
        pointCounter += pointCounter + 20;
      } else if (serviceType == 'referredAFriend') {
        pointCounter += pointCounter + 10;
      }
      await _collection.doc(points.id).set(points.toFirestoreMap());
    } catch (e) {
      print('Error creating LoyaltyPoints: $e');
      throw Exception('Failed to create LoyaltyPoints');
    }
  }

  // Read a LoyaltyPoints document by ID
  Future<LoyaltyPoints?> getLoyaltyPointsById(String id) async {
    try {
      DocumentSnapshot doc = await _collection.doc(id).get();
      if (doc.exists) {
        return LoyaltyPoints.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error reading LoyaltyPoints: $e');
      throw Exception('Failed to read LoyaltyPoints');
    }
  }

  // Update an existing LoyaltyPoints document
  Future<void> updateLoyaltyPoints(
      String id, Map<String, dynamic> updatedData) async {
    try {
      await _collection.doc(id).update(updatedData);
    } catch (e) {
      print('Error updating LoyaltyPoints: $e');
      throw Exception('Failed to update LoyaltyPoints');
    }
  }

  // Delete a LoyaltyPoints document by ID
  Future<void> deleteLoyaltyPoints(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      print('Error deleting LoyaltyPoints: $e');
      throw Exception('Failed to delete LoyaltyPoints');
    }
  }

  // Read all LoyaltyPoints documents
  Future<List<LoyaltyPoints>> getAllLoyaltyPoints() async {
    try {
      QuerySnapshot querySnapshot = await _collection.get();
      return querySnapshot.docs.map((doc) {
        return LoyaltyPoints.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error reading all LoyaltyPoints: $e');
      throw Exception('Failed to fetch LoyaltyPoints');
    }
  }
}
