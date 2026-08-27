import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite(FavoriteModel favorite);
  Future<void> removeFavorite(String id);
}
