import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';

class SearchApiService {
  final Dio dio;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchApiService({required this.dio});

  Future<List<DestinationModel>> searchDestination(String query) async {
    try {
      final snapshot = await _firestore.collection('destinations').get();

      if (snapshot.docs.isNotEmpty) {
        final destinations = snapshot.docs.map((doc) {
          final data = doc.data();
          return DestinationModel(
            id: doc.id,
            name: data['name'] ?? '',
            location: data['location'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
            rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
          );
        }).toList();

        final searchQuery = query.trim().toLowerCase();
        if (searchQuery.isEmpty) return destinations;

        return destinations.where((d) =>
            d.name.toLowerCase().contains(searchQuery) ||
            d.location.toLowerCase().contains(searchQuery)).toList();
      }

      // Fallback data
      final fallbackList = [
        const DestinationModel(
          id: "1",
          name: "Dubai",
          location: "United Arab Emirates",
          imageUrl: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=500&q=80",
          rating: 4.8,
        ),
        const DestinationModel(
          id: "2",
          name: "Paris",
          location: "France",
          imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80",
          rating: 4.7,
        ),
        const DestinationModel(
          id: "3",
          name: "Bali",
          location: "Indonesia",
          imageUrl: "https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80",
          rating: 4.9,
        ),
      ];

      final q = query.trim().toLowerCase();
      if (q.isEmpty) return fallbackList;
      return fallbackList.where((d) =>
          d.name.toLowerCase().contains(q) ||
          d.location.toLowerCase().contains(q)).toList();
    } catch (_) {
      return [];
    }
  }
}
