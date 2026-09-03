import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class HomeRepository {
  Future<List<Movie>> getPopularMovies(int page);

  Future<List<Movie>> getTrendingMovies(int page);

  Future<List<Movie>> getNowPlayingMovies(int page);

  Future<List<Movie>> getTopRatedMovies(int page);
}