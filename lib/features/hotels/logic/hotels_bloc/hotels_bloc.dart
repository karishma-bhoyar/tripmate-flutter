import 'package:flutter_application_tripmate/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_event.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelsRepository repository;

  HotelsBloc({required this.repository}) : super(HotelsInitial()) {
    on<FetchHotelsEvent>((event, emit) async {
      emit(HotelsLoading());
      try {
        final hotels = await repository.getHotelsForDestination(event.destinationName);
        emit(HotelsLoaded(hotels));
      } catch (e) {
        emit(HotelsError(e.toString()));
      }
    });
  }
}
