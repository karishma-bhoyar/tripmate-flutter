import 'package:flutter_application_tripmate/features/favorites/models/favorite_model.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;

  const FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);
}
