import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';

abstract class BookingsEvent {
  const BookingsEvent();
}

class FetchBookingsEvent extends BookingsEvent {
  const FetchBookingsEvent();
}

class CreateBookingEvent extends BookingsEvent {
  final BookingModel booking;

  const CreateBookingEvent(this.booking);
}

class CancelBookingEvent extends BookingsEvent {
  final String bookingId;

  const CancelBookingEvent(this.bookingId);
}
