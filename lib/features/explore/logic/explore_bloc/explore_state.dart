import 'package:flutter_application_tripmate/features/explore/data/models/explore_destination_model.dart';

abstract class ExploreState {
  const ExploreState();
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<ExploreDestinationModel> destinations;

  const ExploreLoaded(this.destinations);
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);
}
