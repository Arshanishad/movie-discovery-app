import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class SearchRepository {
  Future<List<Movie>> searchMovies(String query);
}