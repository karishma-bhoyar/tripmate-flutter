import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';

abstract class BookingsState {
  const BookingsState();
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingModel> bookings;

  const BookingsLoaded(this.bookings);
}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError(this.message);
}
