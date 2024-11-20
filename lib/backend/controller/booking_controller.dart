// lib/backend/controllers/booking_controller.dart
import 'package:stage_mgt_app/backend/interfaces/booking_controller.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';

class BookingController {
  final BookingServiceInterface _bookingService;

  BookingController(this._bookingService);

  Future<String> createBooking(BookingModel booking) async {
    try {
      return await _bookingService.createBooking(booking);
    } catch (e) {
      rethrow;
    }
  }

  Future<BookingModel?> getBookingDetails(String bookingId) async {
    try {
      return await _bookingService.getBookingDetails(bookingId);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    try {
      return await _bookingService.cancelBooking(bookingId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BookingModel>> getTravelHistory(String userId) async {
    try {
      return await _bookingService.getTravelHistory(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<BookingModel?> getUpcomingBooking(String userId) async {
    try {
      return await _bookingService.getUpcomingBooking(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateBooking(
      String bookingId, BookingModel updatedBooking) async {
    try {
      return await _bookingService.updateBooking(bookingId, updatedBooking);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BookingModel>> getUpcomingBookings(String userId) async {
    try {
      return await _bookingService.getUpcomingBookings(userId);
    } catch (e) {
      rethrow;
    }
  }
}
