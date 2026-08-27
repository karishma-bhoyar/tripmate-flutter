import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';

abstract class BookingsRepository {
  Future<List<BookingModel>> fetchBookings();
  Future<void> addBooking(BookingModel booking);
  Future<void> cancelBooking(String bookingId);
}
