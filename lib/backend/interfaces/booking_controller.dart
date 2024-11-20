// lib/backend/services/interfaces/booking_service_interface.dart
import 'package:stage_mgt_app/backend/models/booking.dart';

abstract class BookingServiceInterface {
  Future<String> createBooking(BookingModel booking);
  Future<BookingModel?> getBookingDetails(String bookingId);
  Future<bool> cancelBooking(String bookingId);
  Future<List<BookingModel>> getTravelHistory(String userId);
  Future<BookingModel?> getUpcomingBooking(String userId);
  Future<BookingModel?> getAllBooking(String userId);
  Future<bool> updateBooking(String bookingId, BookingModel updatedBooking);
  Future<List<BookingModel>> getUpcomingBookings(String userId);
}
