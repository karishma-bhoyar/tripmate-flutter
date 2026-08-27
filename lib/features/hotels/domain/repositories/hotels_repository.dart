import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';

abstract class HotelsRepository {
  Future<List<HotelData>> getHotelsForDestination(String destinationName);
}
