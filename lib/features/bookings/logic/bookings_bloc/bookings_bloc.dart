import 'package:flutter_application_tripmate/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:flutter_application_tripmate/features/bookings/logic/bookings_bloc/bookings_event.dart';
import 'package:flutter_application_tripmate/features/bookings/logic/bookings_bloc/bookings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingsRepository repository;

  BookingsBloc({required this.repository}) : super(BookingsInitial()) {
    on<FetchBookingsEvent>((event, emit) async {
      emit(BookingsLoading());
      try {
        final bookings = await repository.fetchBookings();
        emit(BookingsLoaded(bookings));
      } catch (e) {
        emit(BookingsError(e.toString()));
      }
    });

    on<CreateBookingEvent>((event, emit) async {
      try {
        await repository.addBooking(event.booking);
        final bookings = await repository.fetchBookings();
        emit(BookingsLoaded(bookings));
      } catch (e) {
        emit(BookingsError(e.toString()));
      }
    });

    on<CancelBookingEvent>((event, emit) async {
      try {
        await repository.cancelBooking(event.bookingId);
        final bookings = await repository.fetchBookings();
        emit(BookingsLoaded(bookings));
      } catch (e) {
        emit(BookingsError(e.toString()));
      }
    });
  }
}
