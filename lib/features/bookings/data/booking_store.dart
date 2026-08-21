import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';
import 'package:hive/hive.dart';

class BookingStore {
  static const String _boxName = 'bookingsBox';

  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    loadBooking();
  }

  static final List<BookingModel> bookings = [];

  static void loadBooking() {
    bookings.clear();
    for (final item in _box.values) {
      final booking = BookingModel.fromMap(Map<String, dynamic>.from(item));
      bookings.add(booking);
    }
  }

  static Future<void> addBooking(BookingModel booking) async {
    await _box.put(booking.id, booking.toMap());
    bookings.insert(0, booking);
  }

  static Future<void> cancelBooking(String bookingId) async {
    final booking = bookings.firstWhere((booking) => booking.id == bookingId);
    final cancelledBooking = BookingModel(
      id: booking.id,
      hotelName: booking.hotelName,
      location: booking.location,
      imageUrl: booking.imageUrl,
      roomName: booking.roomName,
      roomPrice: booking.roomPrice,
      checkInDate: booking.checkInDate,
      checkOutDate: booking.checkOutDate,
      guestCount: booking.guestCount,
      totalAmount: booking.totalAmount,
      status: BookingStatus.cancelled,
    );
    await _box.put(bookingId, cancelledBooking.toMap());
    final index = bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      bookings[index] = cancelledBooking;
    }
  }
}
