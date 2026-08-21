import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:flutter_application_tripmate/features/search/data/datasources/search_api_service.dart';
import 'package:flutter_application_tripmate/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService searchApiService;

  SearchRepositoryImpl({required this.searchApiService});
  @override
  Future<List<DestinationModel>> searchDestination(String query) async {
    return await searchApiService.searchDestination(query);
  }
}
