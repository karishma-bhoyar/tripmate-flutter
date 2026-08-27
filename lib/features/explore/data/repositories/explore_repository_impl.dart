import 'package:flutter_application_tripmate/features/explore/data/datasources/explore_api_service.dart';
import 'package:flutter_application_tripmate/features/explore/data/models/explore_destination_model.dart';
import 'package:flutter_application_tripmate/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreApiService apiService;

  ExploreRepositoryImpl({required this.apiService});

  @override
  Future<List<ExploreDestinationModel>> getExploreDestinations() async {
    return await apiService.getExploreDestinations();
  }
}
