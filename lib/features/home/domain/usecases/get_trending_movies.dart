import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/home/domain/repositories/home_repository.dart';

class GetTrendingMovies {
  final HomeRepository repository;

  GetTrendingMovies(this.repository);

  Future<List<Movie>> call(int page) async {
    return await repository.getTrendingMovies(page);
  }
}