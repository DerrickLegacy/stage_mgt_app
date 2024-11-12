import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/ErrorMessage/error_handle.dart';
import 'package:stage_mgt_app/backend/controllers/user_controller.dart';
import 'package:stage_mgt_app/backend/models/user.dart';

class UserService implements UserController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> deleteUserAccount(String userId) {
    // TODO: implement deleteUserAccount
    throw UnimplementedError();
  }

  @override
  Future<User?> getUserDetails(String userId) async {
    try {
      var userSnapshot = await _db.collection("users").doc(userId).get();

      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        return User.fromMap(data);
      } else {
        print("User not found");
        return null;
      }
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      var userSnapshot =
          await _db.collection("users").where("email", isEqualTo: email).get();

      if (userSnapshot.docs.isNotEmpty) {
        var user = userSnapshot.docs.first.data();
        String storedPassword = user['password'];

        if (storedPassword == password) {
          String userId = userSnapshot.docs.first.id;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', userId);
          prefs.setString('email', user['email']);
          prefs.setString('username', user['username']);
          prefs.setString('phoneNumber', user['phoneNumber']);
          prefs.setString('address', user['address']);
          prefs.setString('userType', user['userType']);
          prefs.setBool('isLoggedIn', true);

          return User.fromMap(user);
        } else {
          print('Invalid password');
          return null;
        }
      } else {
        print("No user found with that email");
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

// Fetch the cached user details from SharedPreferences (for offline login)
  Future<User?> getCachedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored user details from SharedPreferences
    String? userId = prefs.getString('userId');
    if (userId != null) {
      return User(
        userId: userId, // Use the cached userId
        email: prefs.getString('email') ?? '',
        username: prefs.getString('username') ?? '',
        password: '', // Optionally store the password or leave it empty
        phoneNumber: prefs.getString('phoneNumber') ?? '',
        address: prefs.getString('address') ?? '',
        userType: prefs.getString('userType') ?? '0',
      );
    }
    return null; // No cached user found
  }

  @override
  Future<void> registerUser(Map<String, dynamic> userDetails) async {
    try {
      var userRef = await _db.collection("users").add(userDetails);
      String userId = userRef.id;
      await userRef.update({
        'userId': userId,
        'userType': 0,
      });
      print('User registered with userId: $userId');
    } catch (e) {
      throw ErrorMessage(
          errorMessage: '"User registration failed"', error: '$e');
    }
  }

  @override
  Future<void> updateUserAccount(
      String userId, Map<String, dynamic> userData) async {
    try {
      var userRef = _db.collection("users").doc(userId);
      await userRef.update(userData);
      print('User records updated.');
    } catch (e) {
      throw Exception('User update failed: $e');
    }
  }

  @override
  Future<bool> checkUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  @override
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}
