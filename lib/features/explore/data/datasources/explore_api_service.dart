import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/features/explore/data/models/explore_destination_model.dart';

class ExploreApiService {
  final Dio dio;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ExploreApiService({required this.dio});

  Future<List<ExploreDestinationModel>> getExploreDestinations() async {
    try {
      final snapshot = await _firestore.collection('destinations').get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return ExploreDestinationModel(
            imageUrl: data['imageUrl'] ?? '',
            name: data['name'] ?? '',
            location: data['location'] ?? '',
            rating: (data['rating'] as num?)?.toDouble() ?? 4.5,
            category: data['category'] ?? 'Beach',
            price: (data['price'] as num?)?.toDouble() ?? 10000.0,
          );
        }).toList();
      }

      // Seed destinations to Firestore if empty
      final initialItems = [
        {
          'id': 'dest_1',
          'imageUrl':
              'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80',
          'name': 'Bali',
          'location': 'Indonesia',
          'rating': 4.8,
          'category': 'Beach',
          'price': 35000.0,
        },
        {
          'id': 'dest_2',
          'imageUrl':
              'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?auto=format&fit=crop&w=500&q=80',
          'name': 'Maldives',
          'location': 'South Asia',
          'rating': 4.9,
          'category': 'Beach',
          'price': 48000.0,
        },
        {
          'id': 'dest_3',
          'imageUrl':
              'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80',
          'name': 'Paris',
          'location': 'France',
          'rating': 4.7,
          'category': 'City',
          'price': 10000.0,
        },
        {
          'id': 'dest_4',
          'imageUrl':
              'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=500&q=80',
          'name': 'Tokyo',
          'location': 'Japan',
          'rating': 4.6,
          'category': 'City',
          'price': 20000.0,
        },
        {
          'id': 'dest_5',
          'imageUrl':
              'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=500&q=80',
          'name': 'Switzerland',
          'location': 'Alps, Europe',
          'rating': 4.9,
          'category': 'Mountain',
          'price': 42000.0,
        },
        {
          'id': 'dest_6',
          'imageUrl':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=500&q=80',
          'name': 'Queenstown',
          'location': 'New Zealand',
          'rating': 4.9,
          'category': 'Adventure',
          'price': 38000.0,
        },
      ];

      for (var item in initialItems) {
        await _firestore.collection('destinations').doc(item['id'] as String).set({
          'imageUrl': item['imageUrl'],
          'name': item['name'],
          'location': item['location'],
          'rating': item['rating'],
          'category': item['category'],
          'price': item['price'],
        });
      }

      return initialItems
          .map((json) => ExploreDestinationModel.fromJson(json))
          .toList();
    } catch (_) {
      return [
        ExploreDestinationModel(
          imageUrl:
              'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80',
          name: 'Bali',
          location: 'Indonesia',
          rating: 4.8,
          category: 'Beach',
          price: 35000.0,
        ),
      ];
    }
  }
}
