abstract class HotelsEvent {
  const HotelsEvent();
}

class FetchHotelsEvent extends HotelsEvent {
  final String destinationName;

  const FetchHotelsEvent(this.destinationName);
}
