import 'package:flutter_application_tripmate/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_event.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc({required this.repository}) : super(FavoritesInitial()) {
    on<FetchFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favorites = await repository.getFavorites();
        emit(FavoritesLoaded(favorites));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        final currentFavorites = await repository.getFavorites();
        final exists = currentFavorites.any((item) => item.id == event.favorite.id);
        if (exists) {
          await repository.removeFavorite(event.favorite.id);
        } else {
          await repository.addFavorite(event.favorite);
        }
        final updated = await repository.getFavorites();
        emit(FavoritesLoaded(updated));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      try {
        await repository.removeFavorite(event.id);
        final updated = await repository.getFavorites();
        emit(FavoritesLoaded(updated));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}
