// lib/backend/services/implementations/booking_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_mgt_app/backend/interfaces/booking_controller.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';

class BookingService implements BookingServiceInterface {
  final FirebaseFirestore _db;
  final String collection = 'bookings';

  BookingService({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<String> createBooking(BookingModel booking) async {
    try {
      final batch = _db.batch();
      final docRef = _db.collection(collection).doc();

      final bookingWithId = booking.copyWith(bookingId: docRef.id);
      batch.set(docRef, bookingWithId.toMap());

      // Commit the batch
      await batch.commit();

      return docRef.id;
    } catch (e) {
      throw _handleError('Error creating booking', e);
    }
  }

  @override
  Future<BookingModel?> getBookingDetails(String bookingId) async {
    try {
      final docSnapshot = await _db.collection(collection).doc(bookingId).get();

      if (!docSnapshot.exists) {
        return null;
      }

      return BookingModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw _handleError('Error fetching booking details', e);
    }
  }

  @override
  Future<bool> cancelBooking(String bookingId) async {
    try {
      await _db.collection(collection).doc(bookingId).delete();
      return true;
    } catch (e) {
      throw _handleError('Error canceling booking', e);
    }
  }

  @override
  Future<List<BookingModel>> getTravelHistory(String userId) async {
    try {
      final querySnapshot = await _db
          .collection(collection)
          .where('userId', isEqualTo: userId)
          .where('travelDate', isLessThan: DateTime.now().toIso8601String())
          .orderBy('travelDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw _handleError('Error fetching travel history', e);
    }
  }

  @override
  Future<BookingModel?> getUpcomingBooking(String userId) async {
    try {
      final querySnapshot = await _db
          .collection(collection)
          .where('userId', isEqualTo: userId)
          .where('travelDate', isGreaterThan: DateTime.now().toIso8601String())
          .orderBy('travelDate')
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return BookingModel.fromMap(querySnapshot.docs.first.data());
    } catch (e) {
      throw _handleError('Error fetching upcoming booking', e);
    }
  }

  @override
  Future<bool> updateBooking(
      String bookingId, BookingModel updatedBooking) async {
    try {
      await _db
          .collection(collection)
          .doc(bookingId)
          .update(updatedBooking.toMap());
      return true;
    } catch (e) {
      throw _handleError('Error updating booking', e);
    }
  }

  @override
  Future<List<BookingModel>> getUpcomingBookings(String userId) async {
    try {
      final querySnapshot = await _db
          .collection(collection)
          .where('userId', isEqualTo: userId)
          .where('travelDate', isGreaterThan: DateTime.now().toIso8601String())
          .orderBy('travelDate')
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw _handleError('Error fetching upcoming bookings', e);
    }
  }

  // Helper method to handle errors
  Exception _handleError(String message, dynamic error) {
    print('$message: $error');
    return Exception('$message: ${error.toString()}');
  }

  @override
  Future<BookingModel?> getAllBooking(String userId) {
    // TODO: implement getAllBooking
    throw UnimplementedError();
  }
}
