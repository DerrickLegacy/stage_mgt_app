class BookingModel {
  final String bookingId;
  final String name;
  final String userId;
  final String from;
  final String to;
  final String travelDate;
  final String numberOfPassengers;
  final String paymentMethod;
  final String status;
  final String distance;
  final String travelTime;
  final String contactNumber;
  final String emailAddress;
  final String cardNumber;
  final String cvc;
  final String vehicleType;
  final int milageCost;
  final int totalCost;

  BookingModel({
    required this.bookingId,
    required this.name,
    required this.userId,
    required this.from,
    required this.to,
    required this.travelDate,
    required this.numberOfPassengers,
    required this.paymentMethod,
    required this.status,
    required this.distance,
    required this.travelTime,
    required this.contactNumber,
    required this.emailAddress,
    required this.cardNumber,
    required this.cvc,
    required this.vehicleType,
    required this.milageCost,
    required this.totalCost,
  });

  /// Converts the object to a map for serialization
  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'name': name,
      'userId': userId,
      'from': from,
      'to': to,
      'travelDate': travelDate,
      'numberOfPassengers': numberOfPassengers,
      'paymentMethod': paymentMethod,
      'status': status,
      'distance': distance,
      'travelTime': travelTime,
      'contactNumber': contactNumber,
      'emailAddress': emailAddress,
      'cardNumber': cardNumber,
      'cvc': cvc,
      'vehicleType': vehicleType,
      'milageCost': milageCost,
      'totalCost': totalCost,
    };
  }

  /// Creates an object from a map
  factory BookingModel.fromMap(Map<String, dynamic> data) {
    return BookingModel(
      bookingId: data['bookingId'] ?? '',
      name: data['name'] ?? '',
      userId: data['userId'] ?? '',
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      travelDate: data['travelDate'] ?? '',
      numberOfPassengers: data['numberOfPassengers'] ?? '',
      paymentMethod: data['paymentMethod'] ?? '',
      status: data['status'] ?? '',
      distance: data['distance'] ?? '',
      travelTime: data['travelTime'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      emailAddress: data['emailAddress'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      cvc: data['cvc'] ?? '',
      vehicleType: data['vehicleType'] ?? '',
      milageCost: (data['milageCost'] ?? 0) as int,
      totalCost: (data['totalCost'] ?? 0) as int,
    );
  }

  /// Creates a copy of the object with updated values
  BookingModel copyWith({
    String? bookingId,
    String? name,
    String? userId,
    String? from,
    String? to,
    String? travelDate,
    String? numberOfPassengers,
    String? paymentMethod,
    String? status,
    String? distance,
    String? travelTime,
    String? contactNumber,
    String? emailAddress,
    String? cardNumber,
    String? cvc,
    String? vehicleType,
    int? milageCost,
    int? totalCost,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      from: from ?? this.from,
      to: to ?? this.to,
      travelDate: travelDate ?? this.travelDate,
      numberOfPassengers: numberOfPassengers ?? this.numberOfPassengers,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      travelTime: travelTime ?? this.travelTime,
      contactNumber: contactNumber ?? this.contactNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      cardNumber: cardNumber ?? this.cardNumber,
      cvc: cvc ?? this.cvc,
      vehicleType: vehicleType ?? this.vehicleType,
      milageCost: milageCost ?? this.milageCost,
      totalCost: totalCost ?? this.totalCost,
    );
  }
}
