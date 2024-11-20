class LoyaltyPoints {
  final String id;
  final String userId;
  final String pointCount;
  final String countGoal;

  LoyaltyPoints({
    required this.id,
    required this.userId,
    required this.pointCount,
    required this.countGoal,
  });

  // Convert LoyaltyPoints object to a map for Firestore
  Map<String, dynamic> toFirestoreMap() {
    return {
      'userId': userId,
      'pointCount': pointCount,
      'countGoal': countGoal,
    };
  }

  // Create a LoyaltyPoints object from Firestore data
  factory LoyaltyPoints.fromMap(Map<String, dynamic> data) {
    return LoyaltyPoints(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      pointCount: data['pointCount'] ?? '',
      countGoal: data['countGoal'] ?? '',
    );
  }
}
