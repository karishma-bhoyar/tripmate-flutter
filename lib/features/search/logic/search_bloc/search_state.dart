import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<DestinationModel> destination;

  SearchLoaded(this.destination);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
