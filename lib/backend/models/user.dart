class User {
  final String userId;
  final String email;
  final String username;
  final String password;
  final String phoneNumber;
  final String address;
  final String userType;

  User({
    required this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.address,
    this.userType = '0',
  });

  // Convert User object to a map for Firestore
  Map<String, dynamic> toFirestoreMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'userType': userType,
    };
  }

  // Create a User object from Firestore data
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['userId'] ?? '',
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      userType: data['userType'].toString(), // Ensure userType is a string
    );
  }
}
