abstract class ComingSoonEvent {}

class GetUpcomingMoviesEvent extends ComingSoonEvent {
  final int page;

  GetUpcomingMoviesEvent(this.page);
}