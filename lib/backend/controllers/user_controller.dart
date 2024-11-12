// User classes

import 'package:stage_mgt_app/backend/models/user.dart';

abstract class UserController {
  Future<void> registerUser(Map<String, dynamic> userDetails);
  Future<void> deleteUserAccount(String userId);
  Future<void> getUserDetails(String userId);
  Future<User?> loginUser(String email, String password);
  Future<void> updateUserAccount(String id, Map<String, dynamic> userData);
  Future<void> _storeUserSession(Map<String, dynamic> user);
  Future<void> logoutUser();
  Future<bool> checkUserSession();
}
