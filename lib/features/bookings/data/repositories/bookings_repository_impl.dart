import 'package:flutter_application_tripmate/features/bookings/data/datasources/bookings_api_service.dart';
import 'package:flutter_application_tripmate/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingsApiService apiService;

  BookingsRepositoryImpl({required this.apiService});

  @override
  Future<List<BookingModel>> fetchBookings() async {
    return await apiService.fetchBookings();
  }

  @override
  Future<void> addBooking(BookingModel booking) async {
    await apiService.addBooking(booking);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await apiService.cancelBooking(bookingId);
  }
}
