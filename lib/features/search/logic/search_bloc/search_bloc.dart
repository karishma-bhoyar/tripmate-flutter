import 'package:flutter_application_tripmate/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_event.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;
  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<PerformSearchEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final result = await repository.searchDestination(event.query);
        emit(SearchLoaded(result));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
