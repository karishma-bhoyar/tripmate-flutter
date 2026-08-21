import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';
import 'package:hive/hive.dart';

class FavoriteStore {
  static const String _boxName = "favoritesBox";
  static late Box _box;
  static Box get box => _box;

  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  static List<FavoriteModel> getAllFavorites() {
    return _box.values
        .map((item) => FavoriteModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<void> addFavorite(FavoriteModel favorite) async {
    await _box.put(favorite.id, favorite.toMap());
  }

  static Future<void> removeFavorite(String id) async {
    await _box.delete(id);
  }

  static bool isFavorite(String id) {
    return _box.containsKey(id);
  }

  static FavoriteModel? getFavorite(String id) {
    final item = _box.get(id);
    if (item == null) {
      return null;
    }
    return FavoriteModel.fromMap(Map<String, dynamic>.from(item));
  }
}
