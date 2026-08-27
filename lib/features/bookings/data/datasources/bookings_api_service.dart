import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';

class BookingsApiService {
  final Dio dio;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BookingsApiService({required this.dio});

  String? get _userId => _auth.currentUser?.uid;

  Future<List<BookingModel>> fetchBookings() async {
    try {
      final uid = _userId;
      if (uid != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('bookings')
            .get();

        if (snapshot.docs.isNotEmpty) {
          final cloudBookings = snapshot.docs.map((doc) {
            final data = doc.data();
            return BookingModel.fromMap(data);
          }).toList();

          // Sync into Hive store for offline capability
          for (var b in cloudBookings) {
            await BookingStore.addBooking(b);
          }
          return cloudBookings;
        }
      }
      return BookingStore.bookings;
    } catch (_) {
      return BookingStore.bookings;
    }
  }

  Future<void> addBooking(BookingModel booking) async {
    await BookingStore.addBooking(booking);
    try {
      final uid = _userId;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('bookings')
            .doc(booking.id)
            .set(booking.toMap());
      }
    } catch (_) {
      // Offline fallback
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    await BookingStore.cancelBooking(bookingId);
    try {
      final uid = _userId;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('bookings')
            .doc(bookingId)
            .update({'status': 'Cancelled'});
      }
    } catch (_) {
      // Offline fallback
    }
  }
}
