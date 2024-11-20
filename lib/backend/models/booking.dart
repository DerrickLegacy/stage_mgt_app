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
  });

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
    };
  }

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
    );
  }

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
    String? contactNumber,
    String? distance,
    String? travelTime,
    String? emailAddress,
    String? cardNumber,
    String? cvc,
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
      emailAddress: emailAddress ?? this.emailAddress,
      distance: distance ?? this.distance,
      travelTime: travelTime ?? this.travelTime,
      contactNumber: contactNumber ?? this.contactNumber,
      cardNumber: cardNumber ?? this.cardNumber,
      cvc: cvc ?? this.cvc,
    );
  }
}
