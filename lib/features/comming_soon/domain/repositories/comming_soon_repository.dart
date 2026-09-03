import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class ComingSoonRepository {
  Future<List<Movie>> getUpcomingMovies(int page);
}