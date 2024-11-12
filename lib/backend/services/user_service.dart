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
  Future<void> getUserDetails(String userId) {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      var userSnapshot =
          await _db.collection("users").where("email", isEqualTo: email).get();
      var user = userSnapshot.docs.first.data();

      print(userSnapshot);
      if (userSnapshot.docs.isNotEmpty) {
        var user = userSnapshot.docs.first.data();
        String storedPassword = user['password'];

        if (storedPassword == password) {
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

  @override
  Future<void> registerUser(Map<String, dynamic> userDetails) async {
    try {
      await _db.collection("users").add(userDetails);
    } catch (e) {
      throw ErrorMessage(
          errorMessage: '"User registration failed"', error: '$e');
    }
  }

  @override
  Future<void> updateUserAccount(String id, Map<String, dynamic> userData) {
    // TODO: implement updateUserAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> checkUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
