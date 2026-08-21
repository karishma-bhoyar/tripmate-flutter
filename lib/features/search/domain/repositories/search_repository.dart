import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';

abstract class SearchRepository {
  Future<List<DestinationModel>> searchDestination(String query);
}
