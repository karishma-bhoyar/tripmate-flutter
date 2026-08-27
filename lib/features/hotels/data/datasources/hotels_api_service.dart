import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';

class HotelsApiService {
  final Dio dio;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HotelsApiService({required this.dio});

  Future<List<HotelData>> getHotelsForDestination(String destinationName) async {
    try {
      final snapshot = await _firestore.collection('hotels').get();

      if (snapshot.docs.isNotEmpty) {
        final list = snapshot.docs.map((doc) {
          final data = doc.data();
          return HotelData(
            id: doc.id,
            name: data['name'] ?? 'Hotel',
            location: data['location'] ?? 'Location',
            price: data['price'] ?? '₹10,000',
            rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
            reviews: (data['reviews'] as num?)?.toInt() ?? 100,
            imageUrl: data['imageUrl'] ??
                'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
          );
        }).toList();

        if (destinationName.isNotEmpty && destinationName != 'All Destinations') {
          final filtered = list.where((h) =>
              h.location.toLowerCase().contains(destinationName.toLowerCase()) ||
              h.name.toLowerCase().contains(destinationName.toLowerCase())).toList();
          if (filtered.isNotEmpty) return filtered;
        }
        return list;
      }

      // Seed initial hotels into Firestore if empty
      final initialHotels = [
        const HotelData(
          id: 'hotel_1',
          name: 'Grand Hyatt Dubai',
          location: 'Downtown, Dubai',
          price: '₹12,500',
          rating: 4.8,
          reviews: 340,
          imageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
        ),
        const HotelData(
          id: 'hotel_2',
          name: 'Burj Al Arab Luxury Resort',
          location: 'Jumeirah, Dubai',
          price: '₹45,000',
          rating: 4.9,
          reviews: 520,
          imageUrl:
              'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=500&q=80',
        ),
        const HotelData(
          id: 'hotel_3',
          name: 'Atlantis The Palm',
          location: 'Palm Jumeirah, Dubai',
          price: '₹28,000',
          rating: 4.7,
          reviews: 410,
          imageUrl:
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=500&q=80',
        ),
      ];

      for (var hotel in initialHotels) {
        await _firestore.collection('hotels').doc(hotel.id).set({
          'name': hotel.name,
          'location': hotel.location,
          'price': hotel.price,
          'rating': hotel.rating,
          'reviews': hotel.reviews,
          'imageUrl': hotel.imageUrl,
        });
      }

      return initialHotels;
    } catch (e) {
      // Fallback if offline
      return [
        const HotelData(
          id: '1',
          name: 'Grand Hyatt Dubai',
          location: 'Downtown, Dubai',
          price: '₹12,500',
          rating: 4.8,
          reviews: 340,
          imageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
        ),
      ];
    }
  }
}
