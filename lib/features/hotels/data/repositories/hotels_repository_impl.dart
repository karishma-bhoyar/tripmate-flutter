import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/features/hotels/data/datasources/hotels_api_service.dart';
import 'package:flutter_application_tripmate/features/hotels/domain/repositories/hotels_repository.dart';

class HotelsRepositoryImpl implements HotelsRepository {
  final HotelsApiService apiService;

  HotelsRepositoryImpl({required this.apiService});

  @override
  Future<List<HotelData>> getHotelsForDestination(String destinationName) async {
    return await apiService.getHotelsForDestination(destinationName);
  }
}
