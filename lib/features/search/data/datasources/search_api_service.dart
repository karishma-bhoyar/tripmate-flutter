import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';

class SearchApiService {
  final Dio dio;

  SearchApiService({required this.dio});

  Future<List<DestinationModel>> searchDestination(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final mockData = [
        {
          "id": "1",
          "name": "Dubai",
          "location": "United Arab Emirates",
          "imageUrl":
              "https://images.unsplash.com/photo-1512453979798-5ea266f8880c",
          "rating": 4.8,
        },
        {
          "id": "2",
          "name": "Paris",
          "location": "France",
          "imageUrl":
              "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
          "rating": 4.7,
        },
        {
          "id": "3",
          "name": "Bali",
          "location": "Indonesia",
          "imageUrl":
              "https://images.unsplash.com/photo-1537996194471-e657df975ab4",
          "rating": 4.9,
        },
      ];

      final destinations = mockData
          .map((json) => DestinationModel.fromJson(json))
          .toList();
      final searchQuery = query.trim().toLowerCase();

      if (query.trim().isEmpty) {
        return destinations;
      }

      return destinations.where((destination) {
        return destination.name.toLowerCase().contains(searchQuery) ||
            destination.location.toLowerCase().contains(searchQuery);
      }).toList();
    } catch (e) {
      throw Exception('Search API failed: $e');
    }
  }
}
