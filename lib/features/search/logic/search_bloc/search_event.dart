abstract class SearchEvent {}

class PerformSearchEvent extends SearchEvent {
  final String query;

  PerformSearchEvent(this.query);
}
