import 'package:flutter_application_tripmate/features/explore/domain/repositories/explore_repository.dart';
import 'package:flutter_application_tripmate/features/explore/logic/explore_bloc/explore_event.dart';
import 'package:flutter_application_tripmate/features/explore/logic/explore_bloc/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository repository;

  ExploreBloc({required this.repository}) : super(ExploreInitial()) {
    on<FetchExploreDestinationsEvent>((event, emit) async {
      emit(ExploreLoading());
      try {
        final destinations = await repository.getExploreDestinations();
        emit(ExploreLoaded(destinations));
      } catch (e) {
        emit(ExploreError(e.toString()));
      }
    });
  }
}
