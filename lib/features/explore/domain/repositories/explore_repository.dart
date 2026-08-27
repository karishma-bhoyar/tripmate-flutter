import 'package:flutter_application_tripmate/features/explore/data/models/explore_destination_model.dart';

abstract class ExploreRepository {
  Future<List<ExploreDestinationModel>> getExploreDestinations();
}
