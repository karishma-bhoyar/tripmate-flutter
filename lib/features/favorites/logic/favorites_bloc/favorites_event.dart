import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class FetchFavoritesEvent extends FavoritesEvent {
  const FetchFavoritesEvent();
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final FavoriteModel favorite;

  const ToggleFavoriteEvent(this.favorite);
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final String id;

  const RemoveFavoriteEvent(this.id);
}
