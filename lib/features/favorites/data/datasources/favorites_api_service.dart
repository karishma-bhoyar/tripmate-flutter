import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

class FavoritesApiService {
  final Dio dio;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoritesApiService({required this.dio});

  String? get _userId => _auth.currentUser?.uid;

  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final uid = _userId;
      if (uid != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .get();

        if (snapshot.docs.isNotEmpty) {
          final cloudFavorites = snapshot.docs.map((doc) {
            final data = doc.data();
            return FavoriteModel.fromMap(data);
          }).toList();

          for (var item in cloudFavorites) {
            await FavoriteStore.addFavorite(item);
          }
          return cloudFavorites;
        }
      }
      return FavoriteStore.getAllFavorites();
    } catch (_) {
      return FavoriteStore.getAllFavorites();
    }
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    await FavoriteStore.addFavorite(favorite);
    try {
      final uid = _userId;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(favorite.id)
            .set(favorite.toMap());
      }
    } catch (_) {
      // Offline fallback
    }
  }

  Future<void> removeFavorite(String id) async {
    await FavoriteStore.removeFavorite(id);
    try {
      final uid = _userId;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(id)
            .delete();
      }
    } catch (_) {
      // Offline fallback
    }
  }
}
