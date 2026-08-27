import 'package:flutter_application_tripmate/features/favorites/data/datasources/favorites_api_service.dart';
import 'package:flutter_application_tripmate/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesApiService apiService;

  FavoritesRepositoryImpl({required this.apiService});

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    return await apiService.getFavorites();
  }

  @override
  Future<void> addFavorite(FavoriteModel favorite) async {
    await apiService.addFavorite(favorite);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await apiService.removeFavorite(id);
  }
}
