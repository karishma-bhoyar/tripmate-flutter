import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';

abstract class HotelsState {
  const HotelsState();
}

class HotelsInitial extends HotelsState {}

class HotelsLoading extends HotelsState {}

class HotelsLoaded extends HotelsState {
  final List<HotelData> hotels;

  const HotelsLoaded(this.hotels);
}

class HotelsError extends HotelsState {
  final String message;

  const HotelsError(this.message);
}
